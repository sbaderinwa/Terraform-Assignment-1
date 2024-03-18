output "virtual_network_name" {
  value = azurerm_virtual_network.HumberID-VNET.name
}

output "address_space" {
  value = azurerm_virtual_network.HumberID-VNET.address_space
}

output "subnet_name" {
  value = azurerm_subnet.HumberID-SUBNET.name
}

output "subnet_address" {
  value = azurerm_subnet.HumberID-SUBNET.address_prefixes
}

output "subnet_id" {
  value = azurerm_subnet.HumberID-SUBNET.id
}

output "network_nsg_name" {
  value = azurerm_network_security_group.network-nsg.name
}