resource "azurerm_postgresql_server" "postgresql_server" {
  name                         = var.server_name
  resource_group_name          = var.network_rg_name
  location                     = var.location
  version                      = "11"
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password
  sku_name                     = "B_Gen5_1"
  ssl_enforcement_enabled      = true
}

resource "azurerm_postgresql_database" "postgresql_database" {
  name                = var.database_name
  resource_group_name = var.network_rg_name
  server_name         = azurerm_postgresql_server.postgresql_server.name
  charset             = "UTF8"
  collation           = "en_US.UTF8"
}