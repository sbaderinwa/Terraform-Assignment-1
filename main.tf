module "rgroup-n01487128" {
  source = "./modules/rgroup-n01487128"

  network_rg_name = "N01487128-RG"
  location        = "Canada Central"
}

module "network-n01487128" {
  source = "./modules/network-n01487128"

  network_rg_name               = module.rgroup-n01487128.network_rg
  location                      = module.rgroup-n01487128.location
  virtual_network_name          = "N01487128-VNET"
  virtual_network_address_space = ["10.0.0.0/16"]
  subnet_name                   = "N01487128-SUBNET"
  subnet_address                = ["10.0.0.0/24"]
  network_security_group_name   = "N01487128-NSG"
}

module "common-n01487128" {
  source = "./modules/common-n01487128"

  location                     = module.rgroup-n01487128.location
  network_rg_name              = module.rgroup-n01487128.network_rg
  log_analytics_workspace_name = "N01487128-log-analytics-workspace"
  recovery_services_vault_name = "N01487128-recovery-service-vault"
  storage_account_name         = "n01487128sa"
}

module "vmlinux-n01487128" {
  source = "./modules/vmlinux-n01487128"

  linux_name = { "n01487128-c-vm1" : "Standard_B1ms",
    "n01487128-c-vm2" : "Standard_B1ms",
  "n01487128-c-vm3" : "Standard_B1ms" }
  vm_size                      = "Standard_B1ms"
  admin_username               = "saheed"
  public_key_path              = "/home/saheed/.ssh/id_rsa.pub"
  private_key_path             = "/home/saheed/.ssh/id_rsa"
  os_disk_storage_account_type = "Standard_LRS"
  os_disk_size                 = 32
  os_disk_caching              = "ReadWrite"
  os_publisher                 = "OpenLogic"
  os_offer                     = "CentOS"
  os_sku                       = "8_2"
  os_version                   = "latest"
  linux_avs                    = "n01487128-linux-avs"
  location                     = module.rgroup-n01487128.location
  network_rg_name              = module.rgroup-n01487128.network_rg
  subnet_id                    = module.network-n01487128.subnet_id
  storage_account_uri          = module.common-n01487128.storage_account_uri
}

module "vmwindows-n01487128" {
  source = "./modules/vmwindows-n01487128"

  windows_admin_username               = "saheed"
  windows_admin_password               = "Password@123"
  windows_os_disk_storage_account_type = "StandardSSD_LRS"
  windows_os_disk_size                 = 128
  windows_os_disk_caching              = "ReadWrite"
  windows_os_publisher                 = "MicrosoftWindowsServer"
  windows_os_offer                     = "WindowsServer"
  windows_os_sku                       = "2016-Datacenter"
  windows_os_version                   = "latest"
  windows_avs                          = "n01487128-windows-avs"
  windows_name                         = "n01487128-w-vm"
  windows_size                         = "Standard_B1ms"
  network_rg_name                      = module.rgroup-n01487128.network_rg
  location                             = module.rgroup-n01487128.location
  subnet_id                            = module.network-n01487128.subnet_id
  nb_count                             = 1
}

module "datadisk-n01487128" {
  source = "./modules/datadisk-n01487128"

  vm_ids          = concat(module.vmlinux-n01487128.linux_id, module.vmwindows-n01487128.windows_id)
  network_rg_name = module.rgroup-n01487128.network_rg
  location        = module.rgroup-n01487128.location
}

module "loadbalancer-n01487128" {
  source = "./modules/loadbalancer-n01487128"

  linux_vm_ids   = module.vmlinux-n01487128.linux_id
  linux_nic_ids  = module.vmlinux-n01487128.linux_nic_id
  linux_hostname = module.vmlinux-n01487128.linux_hostname
  resource_group = module.rgroup-n01487128.network_rg
  location       = module.rgroup-n01487128.location
}

module "database-n01487128" {
  source = "./modules/database-n01487128"

  network_rg_name = module.rgroup-n01487128.network_rg
  location        = module.rgroup-n01487128.location
  server_name     = "n01487128-postgresql-server"
  admin_username  = "psqladmin"
  admin_password  = "H@Sh1CoR3!"
  database_name   = "n01487128-database"
}
