terraform {
  backend "azurerm" {
    resource_group_name  = "tfstaten01487128RG"
    storage_account_name = "tfstaten01487128sa"
    container_name       = "tfstatefiles"
    key                  = "terraform.tfstate"
    access_key           = "G/hoJTrXzJSF9pcnpBDVX7+S8i8VpkSyDYqDfcu+UxP1ri1B3HQCJo2Wt9xvYV/75GVsHU/62+sA+AStSgrWcg=="
  }
}