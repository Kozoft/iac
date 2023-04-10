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
  sku                 = "Basic"
  sku_tier            = "Regional"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.dev.id
  }
}

resource "azurerm_lb_probe" "dev" {
  loadbalancer_id = azurerm_lb.dev.id
  name            = "ssh-running-probe"
  port            = 22
}

resource "azurerm_lb_rule" "dev" {
  loadbalancer_id                = azurerm_lb.dev.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 22
  backend_port                   = 22
  frontend_ip_configuration_name = "PublicIPAddress"
}

resource "azurerm_lb_backend_address_pool" "dev" {
  loadbalancer_id = azurerm_lb.dev.id
  name            = "devBackEndAddressPool"
}

resource "azurerm_network_interface_backend_address_pool_association" "dev" {
  network_interface_id    = azurerm_network_interface.entrance.id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.dev.id
}
