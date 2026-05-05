output "vnet_id" {
  description = "The ID of the created virtual network"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "The name of the created virtual network"
  value       = azurerm_virtual_network.vnet.name
}

output "subnet_ids" {
  description = "The IDs of the created subnets"
  value = {
    for subnet_name, subnet in azurerm_subnet.subnets : subnet_name => subnet.id
  }
}

output "nsg_id" {
  description = "The ID of the Network Security Group"
  value       = azurerm_network_security_group.nsg.id
}

output "aks_subnet_id" {
  description = "The ID of the AKS subnet"
  value       = azurerm_subnet.subnets["aks-subnet"].id
}

output "vm_subnet_id" {
  description = "The ID of the VM subnet"
  value       = azurerm_subnet.subnets["vm-subnet"].id
}
