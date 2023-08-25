provider "aws" {
  region = "us-west-2"
}

## RESOURCES
resource "aws_vpc" "vpc" {
  cidr_block = "10.123.0.0/16"

  tags = merge(local.tags, { Name = "${local.prefix_name}-vpc" })
}

resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true

  tags = merge(local.tags, { Name = "${local.prefix_name}-snet" })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(local.tags, { Name = "${local.prefix_name}-igw" })
}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(local.tags, { Name = "${local.prefix_name}-rt" })
}

resource "aws_route_table_association" "subnet-association" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_security_group" "sg" {
  name        = "${local.prefix_name}-sg"
  description = "Allow traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags, { Name = "${local.prefix_name}-sg" })
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# ssh-keygen -t rsa -b 4096
resource "aws_key_pair" "key" {
  key_name   = "${local.prefix_name}-key"
  public_key = file(local.path)
}

resource "aws_instance" "ec2" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.subnet.id
  vpc_security_group_ids = [aws_security_group.sg.id]
  key_name               = aws_key_pair.key.id

  tags = merge(local.tags, { Name = "${local.prefix_name}-ec2" })
}

## OUTPUTS
output "ec2_public_id" {
  description = "Instance public IP"
  value       = aws_instance.ec2.public_ip
}

output "ec2_ssh_command" {
  description = "SSH command to connect to the instance"
  value       = "ssh -i ${trimsuffix(local.path, ".pub")} ubuntu@${aws_instance.ec2.public_ip}"
}