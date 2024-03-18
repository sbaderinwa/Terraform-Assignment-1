output "network_rg" {
  value = azurerm_resource_group.rgroup-HumberID.name
}

output "location" {
  value = azurerm_resource_group.rgroup-HumberID.location
}