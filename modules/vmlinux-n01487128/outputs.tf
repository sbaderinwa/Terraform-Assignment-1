output "linux_hostname" {
  value = values(azurerm_linux_virtual_machine.linux-vm)[*].name
}

output "linux_id" {
  value = values(azurerm_linux_virtual_machine.linux-vm)[*].id
}

output "linux_FQDN" {
  value = values(azurerm_public_ip.linux-pip)[*].fqdn
}

output "linux_private_ip_address" {
  value = values(azurerm_network_interface.linux-nic)[*].private_ip_address
}

output "linux_public_ip_address" {
  value = values(azurerm_linux_virtual_machine.linux-vm)[*].public_ip_address
}

output "linux_availability_set" {
  value = azurerm_availability_set.linux_avs.name
}

output "linux_nic_id" {
  value = values(azurerm_network_interface.linux-nic)[*].id
}