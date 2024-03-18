variable "network_rg_name" {}

variable "location" {}

variable "server_name" {
  default = "n01487128-database-server"
}

variable "admin_username" {
  default = "admin"
}

variable "admin_password" {
  default = "password@123"
}

variable "database_name" {
  default = "n01487128-database"
}