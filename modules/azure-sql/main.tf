resource "azurerm_mssql_server" "sql_server" {
  name                         = lower(var.sql_server_name)
  resource_group_name          = var.resource_group_name
  location                     = var.location

  version                      = "12.0"

  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password

  minimum_tls_version          = "1.2"

  tags = var.tags
}

resource "azurerm_mssql_database" "sql_db" {
  name           = var.database_name
  server_id      = azurerm_mssql_server.sql_server.id

  sku_name       = var.sku_name
  max_size_gb    = var.max_size_gb

  tags = var.tags
}

# Allow Azure services to access SQL (important for AKS, apps, etc.)
resource "azurerm_mssql_firewall_rule" "allow_azure" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}