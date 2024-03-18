resource "azurerm_network_interface" "windows-nic" {
  count               = var.nb_count
  name                = "${var.windows_name}-nic${count.index + 1}"
  location            = var.location
  resource_group_name = var.network_rg_name

  ip_configuration {
    name                          = "${var.windows_name}-ipconfig${count.index + 1}"
    subnet_id                     = var.subnet_id
    public_ip_address_id          = element(azurerm_public_ip.windows-pip[*].id, count.index + 1)
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_public_ip" "windows-pip" {
  count               = var.nb_count
  name                = "${var.windows_name}-pip${count.index + 1}"
  resource_group_name = var.network_rg_name
  location            = var.location
  allocation_method   = "Dynamic"
  domain_name_label   = "${var.windows_name}${count.index + 1}"
}

resource "azurerm_windows_virtual_machine" "windows-vm" {
  count               = var.nb_count
  name                = "${var.windows_name}${count.index + 1}"
  resource_group_name = var.network_rg_name
  location            = var.location
  size                = var.windows_size
  admin_username      = var.windows_admin_username
  admin_password      = var.windows_admin_password

  network_interface_ids = [
    element(azurerm_network_interface.windows-nic[*].id, count.index + 1),
  ]

  os_disk {
    name                 = "${var.windows_name}-os-disk${count.index + 1}"
    caching              = var.windows_os_disk_caching
    storage_account_type = var.windows_os_disk_storage_account_type
    disk_size_gb         = var.windows_os_disk_size
  }

  source_image_reference {
    publisher = var.windows_os_publisher
    offer     = var.windows_os_offer
    sku       = var.windows_os_sku
    version   = var.windows_os_version
  }

  winrm_listener {
    protocol = "Http"
  }
}

resource "azurerm_availability_set" "windows_avs" {
  name                         = var.windows_avs
  location                     = var.location
  resource_group_name          = var.network_rg_name
  platform_update_domain_count = 5
  platform_fault_domain_count  = 2
}

resource "azurerm_virtual_machine_extension" "antimalware" {
  count                      = var.nb_count
  name                       = "${var.windows_name}-antimalware-${count.index}"
  virtual_machine_id         = element(azurerm_windows_virtual_machine.windows-vm[*].id, count.index)
  publisher                  = "Microsoft.Azure.Security"
  type                       = "IaaSAntimalware"
  type_handler_version       = "1.3"
  auto_upgrade_minor_version = true
}