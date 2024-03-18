resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = var.log_analytics_workspace_name
  location            = var.location
  resource_group_name = var.network_rg_name
  sku                 = "PerGB2018"
}

resource "azurerm_recovery_services_vault" "recovery_services_vault" {
  name                = var.recovery_services_vault_name
  location            = var.location
  resource_group_name = var.network_rg_name
  sku                 = "Standard"
}

resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = var.network_rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}