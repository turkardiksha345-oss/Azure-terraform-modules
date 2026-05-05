data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                = lower(var.kv_name)
  location            = var.location
  resource_group_name = var.resource_group_name

  tenant_id = data.azurerm_client_config.current.tenant_id
  sku_name  = "standard"

  purge_protection_enabled = false

  tags = var.tags
}

# Example Secret (Optional)
resource "azurerm_key_vault_secret" "example" {
  name         = "example-secret"
  value        = var.example_secret_value
  key_vault_id = azurerm_key_vault.kv.id
}