# purpose: manage providers and resource groups
 
terraform {
    required_providers {
        azurerm = {
        source = "hashicorp/azurerm"
        version = "=2.49.0"
        }
    }
}

provider "azurerm" {
    features {}
    subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "arg" {
    name = "resourcegroup-${var.env}"
    location = var.region
    tags = {
        environment = var.env
    }
}
