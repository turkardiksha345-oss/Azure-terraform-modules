output "vm_id" {
  description = "The ID of the virtual machine"
  value       = azurerm_virtual_machine.vm.id
}

output "vm_name" {
  description = "The name of the virtual machine"
  value       = azurerm_virtual_machine.vm.name
}

output "private_ip_address" {
  description = "The private IP address of the VM"
  value       = azurerm_network_interface.nic.private_ip_address
}

output "public_ip_address" {
  description = "The public IP address of the VM"
  value       = var.enable_public_ip ? azurerm_public_ip.pip[0].ip_address : null
}

output "nic_id" {
  description = "The ID of the network interface"
  value       = azurerm_network_interface.nic.id
}
