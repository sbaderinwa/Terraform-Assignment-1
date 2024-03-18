resource "azurerm_virtual_network" "HumberID-VNET" {
  name                = var.virtual_network_name
  location            = var.location
  resource_group_name = var.network_rg_name
  address_space       = var.virtual_network_address_space
}

resource "azurerm_subnet" "HumberID-SUBNET" {
  name                 = var.subnet_name
  resource_group_name  = var.network_rg_name
  virtual_network_name = azurerm_virtual_network.HumberID-VNET.name
  address_prefixes     = var.subnet_address
}

resource "azurerm_network_security_group" "network-nsg" {
  name                = var.network_security_group_name
  location            = var.location
  resource_group_name = var.network_rg_name

  security_rule {
    name                       = "rule1"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "rule2"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "rule3"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5985"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "rule4"
    priority                   = 103
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "network-association" {
  subnet_id                 = azurerm_subnet.HumberID-SUBNET.id
  network_security_group_id = azurerm_network_security_group.network-nsg.id
}