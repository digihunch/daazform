resource "azurerm_storage_data_lake_gen2_filesystem" "asdl2fs" {
  name               = "asdl2fs${var.env}${random_id.randomId.hex}"
  storage_account_id = azurerm_storage_account.storacc.id

  properties = {
    hello = "aGVsbG8="
  }
}
