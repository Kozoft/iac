# --- cluster ---

resource "azurerm_kubernetes_cluster" "dev" {
  name                = "dev-aks"
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name
  dns_prefix          = "dev"
  kubernetes_version = "1.25.5"
  private_cluster_enabled = true

  default_node_pool {
    name       = "defaultnp"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
    orchestrator_version = "1.25.5"
    vnet_subnet_id = azurerm_subnet.dev.id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }

  tags = {
    Environment = "Development"
  }
}