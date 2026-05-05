output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.main.name
}

output "resource_group_id" {
  description = "ID of the resource group"
  value       = azurerm_resource_group.main.id
}

# Network Outputs
output "vnet_id" {
  description = "Virtual network ID"
  value       = module.network.vnet_id
}

output "vnet_name" {
  description = "Virtual network name"
  value       = module.network.vnet_name
}

output "subnet_ids" {
  description = "IDs of all subnets"
  value       = module.network.subnet_ids
}

# Storage Outputs
output "storage_account_id" {
  description = "Storage account ID"
  value       = module.storage.storage_account_id
}

output "storage_account_name" {
  description = "Storage account name"
  value       = module.storage.storage_account_name
}

output "primary_blob_endpoint" {
  description = "Primary blob endpoint"
  value       = module.storage.primary_blob_endpoint
}

# VM Outputs
output "vm_id" {
  description = "Virtual machine ID"
  value       = module.vm.vm_id
}

output "vm_private_ip" {
  description = "Private IP of the VM"
  value       = module.vm.private_ip_address
}

output "vm_public_ip" {
  description = "Public IP of the VM"
  value       = module.vm.public_ip_address
}

# AKS Outputs
output "aks_cluster_id" {
  description = "AKS cluster ID"
  value       = module.aks.aks_cluster_id
}

output "aks_cluster_name" {
  description = "AKS cluster name"
  value       = module.aks.aks_cluster_name
}

output "aks_fqdn" {
  description = "FQDN of the AKS cluster"
  value       = module.aks.fqdn
}

output "aks_kube_config_raw" {
  description = "Raw Kubernetes config"
  value       = module.aks.kube_config
  sensitive   = true
}
