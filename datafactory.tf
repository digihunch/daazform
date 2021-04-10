# purpose: azure data factory
resource "azurerm_data_factory" "adfmdl" {
  name                = "adf${var.env}${random_id.randomId.hex}"
  location            = azurerm_resource_group.arg.location 
  resource_group_name = azurerm_resource_group.arg.name 
}
