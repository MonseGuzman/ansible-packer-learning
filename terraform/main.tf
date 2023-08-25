data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

resource "random_string" "random_suffix" {
  length  = 5
  special = false
  upper   = false
}

resource "random_string" "password" {
  length      = 20
  min_lower   = 3
  min_upper   = 3
  min_numeric = 3
  min_special = 3
  special     = true
}

resource "local_file" "ansible_inventory" {
  filename = "../ansible/playbooks/inventory"
  content = templatefile("${path.module}/templates/inventory.tftpl",
    {
      ec2_ip       = aws_instance.ec2.public_ip # "0.0.0.0"
      ec2_username = "ubuntu"
      ec2_ssh_path = local.path
      vm_ip        = azurerm_linux_virtual_machine.vm.public_ip_address # "0.0.0.0"
      vm_username  = local.username
      vm_pass      = random_string.password.result
  })
}

## OUTPUTS
output "local_ip" {
  description = "My public IP"
  value       = chomp(data.http.myip.body)
}