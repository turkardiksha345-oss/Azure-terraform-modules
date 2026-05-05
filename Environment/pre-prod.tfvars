# Azure credentials
subscription_id = "your-subscription-id"
tenant_id       = "your-tenant-id"

# General
location            = "East US"
resource_group_name = "rg-azure-terraform"

# Network
vnet_name          = "vnet-main"
vnet_address_space = ["10.0.0.0/16"]

# Storage (must be unique globally)
storage_account_name = "storageunique12345"
storage_account_tier = "Standard"

# ACR (must be unique globally)
acr_name = "acrdevops12345"

# VM
vm_name = "vm-01"
vm_size = "Standard_B2s"

ssh_public_key   = file("~/.ssh/id_rsa.pub")
private_key_path = "~/.ssh/id_rsa"

# AKS Cluster
cluster_name       = "akscluster01"
kubernetes_version = "1.27"
aks_node_count     = 3
aks_node_vm_size   = "Standard_B2s"

# Key Vault (must be unique globally)
kv_name      = "kvdevops12345"
secret_value = "SuperSecret@123"

# Tags for the resources
common_tags = {
  ManagedBy = "Terraform"
  Owner     = "DevOps"
  Project   = "Azure-Infrastructure"
}