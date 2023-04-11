# --- entrance vm ---

resource "azurerm_network_interface" "entrance" {
  name                = "entrance-nic"
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.dev.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "entrance" {
  name                            = "entrance-vm"
  resource_group_name             = azurerm_resource_group.dev.name
  location                        = azurerm_resource_group.dev.location
  size                            = "Standard_D2s_v3"
  admin_username                  = "toor"
  disable_password_authentication = true
  network_interface_ids = [
    azurerm_network_interface.entrance.id,
  ]

  admin_ssh_key {
    username   = "toor"
    public_key = file("${path.root}/bornik")
  }

  admin_ssh_key {
    username   = "toor"
    public_key = file("${path.root}/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Debian"
    offer     = "debian-11"
    sku       = "11-backports-gen2"
    version   = "latest"
  }
}
