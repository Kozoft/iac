# --- cluster ---

resource "azurerm_kubernetes_cluster" "dev" {
  name                          = "dev-aks"
  location                      = azurerm_resource_group.dev.location
  resource_group_name           = azurerm_resource_group.dev.name
  dns_prefix                    = "dev"
  kubernetes_version            = "1.25.5"
  private_cluster_enabled       = true
  public_network_access_enabled = false

  default_node_pool {
    name                 = "defaultnp"
    node_count           = 1
    vm_size              = "Standard_DS2_v2"
    orchestrator_version = "1.25.5"
    vnet_subnet_id       = azurerm_subnet.dev.id
    os_disk_type         = "Ephemeral"
    os_disk_size_gb      = 60
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    #upstream dns 168.63.129.16
    #docker-bridge-address 172.17.0.1/16
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    service_cidr      = "10.0.2.0/24"
    dns_service_ip    = "10.0.2.10"
  }

  tags = {
    Environment = "Development"
  }
}
