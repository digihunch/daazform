# purpose: manage network and security resources

resource "azurerm_virtual_network" "avn" {
    name = "virtualnetwork-${var.env}"
    resource_group_name = azurerm_resource_group.arg.name
    location = azurerm_resource_group.arg.location
    address_space = ["10.0.0.0/16"]
    tags = {
        environments = var.env
    }
}

resource "azurerm_network_security_group" "nsg" {
    name = "network_security_group_${var.env}"
    resource_group_name = azurerm_resource_group.arg.name
    location = azurerm_resource_group.arg.location
    tags = {
        environments = var.env
    }
}

resource "azurerm_network_security_rule" "nsrout" {
    name                        = "nsrout"
    priority                    = 100
    direction                   = "Outbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "*"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = azurerm_resource_group.arg.name
    network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "nsrin" {
    name                        = "SSH"
    priority                    = 101
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "22"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = azurerm_resource_group.arg.name
    network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_subnet" "pubsub" {
    name = "publicsubnet-${var.env}"
    resource_group_name = azurerm_resource_group.arg.name
    virtual_network_name = azurerm_virtual_network.avn.name
    address_prefixes = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "myterraformpublicip" {
    name                         = "myPublicIP"
    location                     = azurerm_resource_group.arg.location
    resource_group_name          = azurerm_resource_group.arg.name
    allocation_method            = "Dynamic"

    tags = {
        environment = var.env
    }
}

resource "azurerm_network_interface" "pubnic" {
    name                        = "myNIC"
    location                    = azurerm_resource_group.arg.location
    resource_group_name         = azurerm_resource_group.arg.name 

    ip_configuration {
        name                          = "myNicConfiguration"
        subnet_id                     = azurerm_subnet.pubsub.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.myterraformpublicip.id
    }

    tags = {
        environment = var.env 
    }
}

resource "azurerm_network_interface_security_group_association" "nicscassoc" {
    network_interface_id      = azurerm_network_interface.pubnic.id
    network_security_group_id = azurerm_network_security_group.nsg.id
}

