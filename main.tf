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

#checkov:skip=CKV2_AZURE_1: CMK not required for demo project
#checkov:skip=CKV2_AZURE_33: Private Endpoint not required
#checkov:skip=CKV2_AZURE_41: SAS expiration policy not required
#checkov:skip=CKV2_AZURE_38: Soft delete not required
#checkov:skip=CKV2_AZURE_40: Shared Key auth acceptable for demo
resource "azurerm_storage_account" "main" {
  name                     = lower("st${var.application_name}${var.environment_name}${random_string.suffix.result}")
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = var.accountreplicationtype

  allow_nested_items_to_be_public = false
  min_tls_version                 = "TLS1_2"
}

resource "azurerm_virtual_network" "example" {
  name                = "network-${var.application_name}-${var.environment_name}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = ["10.0.0.0/16"]
}
