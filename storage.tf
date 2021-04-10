# purpose: manage storage account and storage devices

resource "random_id" "randomId" {
    keepers = {
        resource_group = azurerm_resource_group.arg.name
    }
    byte_length = 8
}

# storage account name is randomized to ensure global uniqueness
resource "azurerm_storage_account" "storacc" {
    name                = "stac${var.env}${random_id.randomId.hex}"
    resource_group_name = azurerm_resource_group.arg.name
    location                 = azurerm_resource_group.arg.location
    account_tier             = "Standard"
    account_replication_type = "LRS"
    #account_kind defaults to "StorageV2"
    #is_hns_enabled defaults to True when account_tier is Standard
#    network_rules {
#        default_action             = "Deny"
#        ip_rules                   = ["100.0.0.1"]
#        virtual_network_subnet_ids = [azurerm_subnet.pubsub.id]
#    }

    tags = {
        environment = var.env
    }
}


resource "azurerm_recovery_services_vault" "recservlt" {
    name = "recservlt-${var.env}"
    resource_group_name = azurerm_resource_group.arg.name
    location = azurerm_resource_group.arg.location 
    sku = "Standard"
}
