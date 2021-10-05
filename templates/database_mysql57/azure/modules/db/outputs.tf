output "instance_id" {
  description = "ID of the compute instance"
  value       = azurerm_linux_virtual_machine.example.id
}

output "instance_public_ip" {
  description = "Public IP address of the compute instance"
  value       = azurerm_linux_virtual_machine.example.public_ip_address
}