provider "azurerm" {
  features {
    api_management {
      purge_soft_delete_on_destroy = true
      recover_soft_deleted         = true
    }

    app_configuration {
      purge_soft_delete_on_destroy = true
      recover_soft_deleted         = true
    }

    application_insights {
      disable_generated_rule = true
    }

    resource_group {
      prevent_deletion_if_contains_resources = true
    }

# azurerm_linux_virtual_machine
# azurerm_windows_virtual_machin
    virtual_machine {
      delete_os_disk_on_deletion     = true
      graceful_shutdown              = false
      skip_shutdown_and_force_delete = true
    }
  }
}

resource "azurerm_resource_group" "dev" {
  name     = "dev-rg"
  location = "West Europe"
}
