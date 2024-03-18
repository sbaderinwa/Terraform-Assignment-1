resource "azurerm_resource_group" "rgroup-HumberID" {
  name     = var.network_rg_name
  location = var.location
}