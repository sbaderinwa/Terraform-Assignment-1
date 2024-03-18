variable "location" {}

variable "network_rg_name" {}

variable "log_analytics_workspace_name" {
  default = "N01487128-log-analytics-workspace"
}

variable "recovery_services_vault_name" {
  default = "N01487128-recovery-service-vault"
}

variable "storage_account_name" {
  default = "n01487128_storage_acount"
}