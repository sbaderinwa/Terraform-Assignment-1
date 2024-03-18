variable "windows_admin_username" {
  default = "saheed"
}

variable "windows_admin_password" {
  default = "Password@123"
}

variable "windows_os_disk_storage_account_type" {
  default = "StandardSSD_LRS"
}

variable "windows_os_disk_size" {
  default = 128
}

variable "windows_os_disk_caching" {
  default = "ReadWrite"
}

variable "windows_os_publisher" {
  default = "MicrosoftWindowsServer"
}

variable "windows_os_offer" {
  default = "WindowsServer"
}

variable "windows_os_sku" {
  default = "2016-Datacenter"
}

variable "windows_os_version" {
  default = "latest"
}

variable "windows_avs" {
  default = "n01487128-windows-avs"
}

variable "windows_name" {
  default = "n01487128-w-vm"
}

variable "windows_size" {
  default = "Standard_B1s"
}

variable "network_rg_name" {}

variable "location" {}

variable "subnet_id" {}

variable "nb_count" {
  default = 1
}