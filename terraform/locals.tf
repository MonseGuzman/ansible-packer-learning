locals {
  path        = "~/Documents/aws-key/ansible-key.pub"
  prefix_name = "mons-${random_string.random_suffix.result}"
  username    = "adminuser"

  tags = {
    Owner = "Monse Guzman"
    Stack = "Test"
  }
}