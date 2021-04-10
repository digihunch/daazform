# purpose: manage virtual machines

# RSA key pair for SSH access to VM
resource "tls_private_key" "example_ssh" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "azurerm_linux_virtual_machine" "mytftest" {
    name = "myvm-${var.env}"
    location = azurerm_resource_group.arg.location 
    resource_group_name = azurerm_resource_group.arg.name 
    network_interface_ids = [azurerm_network_interface.pubnic.id]
    size = "Standard_DS1_v2"

    os_disk {
        name = "myOSDisk"
        caching = "ReadWrite"
        storage_account_type = "Premium_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer = "UbuntuServer"
        sku = "18.04-LTS"
        version = "latest"
    }
    computer_name = "myvm-${var.env}"
    admin_username = var.vm_admin_user 
    disable_password_authentication = true
    admin_ssh_key {
        username = var.vm_admin_user
        public_key = tls_private_key.example_ssh.public_key_openssh 
    }
    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.storacc.primary_blob_endpoint 
    }
    
    tags = {
        environment = var.env
    }

}
