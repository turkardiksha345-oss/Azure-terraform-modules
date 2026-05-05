output "storage_account_id" {
  description = "The ID of the storage account"
  value       = azurerm_storage_account.storage.id
}

output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.storage.name
}

output "primary_blob_endpoint" {
  description = "The primary blob endpoint"
  value       = azurerm_storage_account.storage.primary_blob_endpoint
}

output "storage_account_access_key" {
  description = "The primary access key for the storage account"
  value       = azurerm_storage_account.storage.primary_access_key
  sensitive   = true
}

output "container_ids" {
  description = "The IDs of the created storage containers"
  value = {
    for container_name, container in azurerm_storage_container.containers : container_name => container.id
  }
}
