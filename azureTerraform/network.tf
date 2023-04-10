# --- network ---

resource "azurerm_network_security_group" "dev" {
  name                = "dev-security-group"
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name

  security_rule {
    name                       = "allow_ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Development"
  }
}

resource "azurerm_network_interface_security_group_association" "dev" {
  network_interface_id      = azurerm_network_interface.entrance.id
  network_security_group_id = azurerm_network_security_group.dev.id
}

resource "azurerm_virtual_network" "dev" {
  name                = "dev-vnetwork"
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  tags = {
    environment = "Development"
  }
}

resource "azurerm_subnet" "dev" {
  name                 = "dev-subnet"
  resource_group_name  = azurerm_resource_group.dev.name
  virtual_network_name = azurerm_virtual_network.dev.name
  address_prefixes     = ["10.0.1.0/24"]
}
