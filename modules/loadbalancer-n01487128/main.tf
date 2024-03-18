resource "azurerm_public_ip" "public_ip" {
  name                = "N01487128-public-ip"
  resource_group_name = var.resource_group
  location            = var.location
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

resource "azurerm_lb" "lb" {
  name                = "N01487128-lb"
  resource_group_name = var.resource_group
  location            = var.location
  sku                 = "Basic"

  frontend_ip_configuration {
    name                 = "Public_IP"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "backend_address_pool" {
  name            = "BackendPool"
  loadbalancer_id = azurerm_lb.lb.id
}

resource "azurerm_network_interface_backend_address_pool_association" "nic_backend_pool_association" {
  count                   = length(var.linux_vm_ids)
  network_interface_id    = var.linux_nic_ids[count.index]
  ip_configuration_name   = "${var.linux_hostname[count.index]}-ipconfig"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_address_pool.id
}