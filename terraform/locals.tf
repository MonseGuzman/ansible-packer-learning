locals {
  path        = "${path.module}/ansible-key.pem"
  prefix_name = "mons-${random_string.random_suffix.result}"
  username    = "adminuser"

  tags = {
    Owner = "Monse Guzman"
    Stack = "Test"
  }
}