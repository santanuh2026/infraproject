resource "azurerm_resource_group" "main" {
  name     = lower("rg-${var.application_name}-${var.environment_name}")
  location = var.location
}


resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
  numeric = true

}

resource "azurerm_storage_account" "main" {
  name                            = lower("st${var.application_name}${var.environment_name}${random_string.suffix.result}")
  resource_group_name             = azurerm_resource_group.main.name
  location                        = azurerm_resource_group.main.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false
  min_tls_version                 = "TLS1_2"

}
