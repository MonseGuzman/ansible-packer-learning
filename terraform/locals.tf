locals {
  path        = "~/Documents/aws-account/ansible-key.pub"
  prefix_name = "mons-${random_string.random_suffix.result}"
  username    = "adminuser"

  tags = {
    Owner = "Monse Guzman"
    Stack = "Test"
  }
}