resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name            = var.default_node_pool_name
    node_count      = var.enable_auto_scaling ? null : var.default_node_count
    vm_size         = var.default_node_vm_size
    os_disk_size_gb = 30
    vnet_subnet_id  = var.subnet_id

    min_count       = var.enable_auto_scaling ? var.min_node_count : null
    max_count       = var.enable_auto_scaling ? var.max_node_count : null
    type            = "VirtualMachineScaleSets"
    auto_scaling_enabled = var.enable_auto_scaling
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = var.network_plugin
    load_balancer_sku = "standard"
    service_cidr      = "10.1.0.0/16"
    dns_service_ip    = "10.1.0.10"
  }

  role_based_access_control_enabled = var.enable_rbac

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "additional" {
  name                   = "workload"
  kubernetes_cluster_id  = azurerm_kubernetes_cluster.aks.id
  node_count             = 2
  vm_size                = "Standard_B2s"
  os_disk_size_gb        = 30
  os_type                = "Linux"
  auto_scaling_enabled   = var.enable_auto_scaling
  min_count              = var.enable_auto_scaling ? var.min_node_count : null
  max_count              = var.enable_auto_scaling ? var.max_node_count : null

  tags = var.tags
}
