# --- load balancer ---

resource "azurerm_public_ip" "dev" {
  name                = "PublicIPForDevLB"
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name
  allocation_method   = "Static"
}

resource "azurerm_lb" "dev" {
  name                = "DevLoadBalancer"
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.dev.id
  }
}
