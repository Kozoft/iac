# --- network watcher ---

resource "azurerm_resource_group" "NetworkWatcherRG" {
  name     = "NetworkWatcherRG"
  location = "West Europe"
}

resource "azurerm_network_watcher" "NetworkWatcher_westeurope" {
  name                = "NetworkWatcher_westeurope"
  location            = azurerm_resource_group.NetworkWatcherRG.location
  resource_group_name = azurerm_resource_group.NetworkWatcherRG.name
}
