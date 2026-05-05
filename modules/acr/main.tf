resource "azurerm_container_registry" "acr" {
  name                = lower(var.acr_name)   # must be lowercase + globally unique
  resource_group_name = var.resource_group_name
  location            = var.location

  sku           = var.sku
  admin_enabled = var.admin_enabled

  tags = var.tags
}

# Optional: Attach ACR to AKS (VERY IMPORTANT in real projects)
resource "azurerm_role_assignment" "acr_pull" {
  count = var.aks_kubelet_identity != "" ? 1 : 0

  principal_id         = var.aks_kubelet_identity
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.acr.id
}