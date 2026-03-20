## AWS
output "ec2_public_id" {
  description = "Instance public IP"
  value       = aws_instance.ec2.public_ip
}

output "ec2_ssh_command" {
  description = "SSH command to connect to the instance"
  value       = "ssh -i ${trimsuffix(local.path, ".pub")} ubuntu@${aws_instance.ec2.public_ip}"
}

## AZURE
output "vm_public_id" {
  description = "Instance public IP"
  value       = azurerm_linux_virtual_machine.vm.public_ip_address
}

output "vm_ssh_command" {
  description = "SSH command to connect to the virtual machine"
  value       = "ssh ${local.username}@${azurerm_linux_virtual_machine.vm.public_ip_address}"
}

output "vm_password" {
  description = "Your virtual machine password"
  value       = random_string.password.result
  # sensitive   = true
}