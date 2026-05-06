variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
  sensitive   = true
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
}

# ACR
variable "acr_name" {
  description = "Name of Azure Container Registry (must be globally unique)"
  type        = string
}

# Network
variable "vnet_name" {
  description = "Virtual network name"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

# Storage
variable "storage_account_name" {
  description = "Storage account name (globally unique, lowercase)"
  type        = string
}

variable "storage_account_tier" {
  description = "Storage account tier (Standard or Premium)"
  type        = string
  default     = "Standard"
}

# VM
variable "vm_name" {
  description = "Virtual machine name"
  type        = string
  default     = "vm-main"
}

variable "admin_password" {
  description = "Password for VM login"
  type        = string
  sensitive   = true
  
}

variable "vm_size" {
  description = "VM size"
  type        = string
  default     = "Standard_B2s"
}

variable "ssh_public_key" {
  description = "SSH public key for VM"
  type        = string
}

variable "private_key_path" {
  description = "Path to private SSH key (used for provisioner)"
  type        = string
}

# AKS
variable "cluster_name" {
  description = "AKS cluster name"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.27"
}

variable "aks_node_count" {
  description = "Initial number of AKS nodes"
  type        = number
  default     = 3
}

variable "aks_node_vm_size" {
  description = "VM size for AKS nodes"
  type        = string
  default     = "Standard_B2s"
}

# Key Vault
variable "kv_name" {
  description = "Key Vault name (globally unique)"
  type        = string
}

variable "secret_value" {
  description = "Secret value for Key Vault"
  type        = string
  sensitive   = true
}

# Tags
variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    ManagedBy = "Terraform"
  }
}

variable "sql_server_name" {
    description = "Azure SQL server name (globally unique)"
    type        = string
}

variable "sql_admin" {
    description = "Admin username for Azure SQL"
    type        = string
}

variable "sql_password" {
    description = "Admin password for Azure SQL"
    type        = string
    sensitive = true
}
variable "database_name" {
    description = "Azure SQL database name"
    type        = string
}