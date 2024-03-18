resource "azurerm_network_interface" "linux-nic" {
  for_each            = var.linux_name
  name                = "${each.key}-nic"
  location            = var.location
  resource_group_name = var.network_rg_name

  ip_configuration {
    name                          = "${each.key}-ipconfig"
    subnet_id                     = var.subnet_id
    public_ip_address_id          = azurerm_public_ip.linux-pip[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_public_ip" "linux-pip" {
  for_each            = var.linux_name
  name                = "${each.key}-pip"
  resource_group_name = var.network_rg_name
  location            = var.location
  allocation_method   = "Dynamic"
  domain_name_label   = each.key
}

resource "azurerm_linux_virtual_machine" "linux-vm" {
  for_each            = var.linux_name
  name                = each.key
  resource_group_name = var.network_rg_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.linux-nic[each.key].id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.public_key_path)
  }

  os_disk {
    name                 = "${each.key}-os-disk"
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
    disk_size_gb         = var.os_disk_size
  }

  source_image_reference {
    publisher = var.os_publisher
    offer     = var.os_offer
    sku       = var.os_sku
    version   = var.os_version
  }

  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }

  availability_set_id = azurerm_availability_set.linux_avs.id
}

resource "azurerm_virtual_machine_extension" "linux-network-watcher" {
  for_each                   = var.linux_name
  name                       = "NetworkWatcherAgentLinux"
  virtual_machine_id         = azurerm_linux_virtual_machine.linux-vm[each.key].id
  publisher                  = "Microsoft.Azure.NetworkWatcher"
  type                       = "NetworkWatcherAgentLinux"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
}

resource "azurerm_virtual_machine_extension" "azure-monitor" {
  for_each                   = var.linux_name
  name                       = "AzureMonitorLinuxAgent"
  virtual_machine_id         = azurerm_linux_virtual_machine.linux-vm[each.key].id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
}

resource "azurerm_availability_set" "linux_avs" {
  name                         = var.linux_avs
  location                     = var.location
  resource_group_name          = var.network_rg_name
  platform_update_domain_count = 5
  platform_fault_domain_count  = 2
}