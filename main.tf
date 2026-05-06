resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location

  tags = var.common_tags
}

# Network Module
module "network" {
  source = "./modules/network"

  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  vnet_name           = var.vnet_name
  vnet_address_space  = var.vnet_address_space

  tags = var.common_tags
}

# AKS Module (MOVED BEFORE ACR)
module "aks" {
  source = "./modules/aks"

  location            = var.location
  resource_group_name = azurerm_resource_group.main.name

  cluster_name       = var.cluster_name
  kubernetes_version = var.kubernetes_version

  dns_prefix = lower(var.cluster_name)

  subnet_id = module.network.aks_subnet_id

  default_node_count   = var.aks_node_count
  default_node_vm_size = var.aks_node_vm_size

  enable_auto_scaling = true
  min_node_count      = 1
  max_node_count      = 5

  tags = var.common_tags

  depends_on = [module.network]
}

# ACR Module (AFTER AKS)
module "acr" {
  source = "./modules/acr"

  acr_name            = var.acr_name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name

  # FIX: AKS must exist first
  aks_kubelet_identity = module.aks.kubelet_identity_object_id

  depends_on = [module.aks]
}

# Storage Module
module "storage" {
  source = "./modules/storage"

  location             = var.location
  resource_group_name  = azurerm_resource_group.main.name
  storage_account_name = lower(var.storage_account_name)
  storage_account_tier = var.storage_account_tier

  tags = var.common_tags
}

# VM Module
module "vm" {
  source = "./modules/vm"

  location            = var.location
  resource_group_name = azurerm_resource_group.main.name

  vm_name   = var.vm_name
  vm_size   = var.vm_size
  subnet_id = module.network.vm_subnet_id

  admin_password = var.admin_password
  enable_public_ip = true

  tags = var.common_tags

  depends_on = [module.network]
}

# Key Vault
module "keyvault" {
  source = "./modules/keyvault"

  kv_name             = var.kv_name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name

  example_secret_value = var.secret_value
}

module "sql" {
  source = "./modules/azure-sql"

  location            = var.location
  resource_group_name = azurerm_resource_group.main.name

  sql_server_name = var.sql_server_name
  admin_username  = var.sql_admin
  admin_password  = var.sql_password
  database_name   = var.database_name

  tags = var.common_tags
}