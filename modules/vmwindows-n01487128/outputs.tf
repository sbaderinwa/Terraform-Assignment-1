output "windows_availability_set" {
  value = azurerm_availability_set.windows_avs.name
}

output "windows_hostnames" {
  value = azurerm_windows_virtual_machine.windows-vm[*].name
}

output "windows_id" {
  value = azurerm_windows_virtual_machine.windows-vm[*].id
}


output "windows_FQDN" {
  value = azurerm_public_ip.windows-pip[*].fqdn
}

output "windows_private_ip_address" {
  value = azurerm_windows_virtual_machine.windows-vm[*].private_ip_address
}

output "windows_public_ip_address" {
  value = azurerm_windows_virtual_machine.windows-vm[*].public_ip_address
}