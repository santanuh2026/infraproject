output "resource_group_name" {
  description = "Name of the Azure resource group."
  value       = azurerm_resource_group.main.name
}

output "resource_group_id" {
  description = "Resource ID of the Azure resource group."
  value       = azurerm_resource_group.main.id
}

output "storage_account_name" {
  description = "Name of the Azure storage account."
  value       = azurerm_storage_account.main.name
}

output "storage_account_id" {
  description = "Resource ID of the Azure storage account."
  value       = azurerm_storage_account.main.id
}

output "storage_account_primary_blob_endpoint" {
  description = "Primary blob endpoint for the Azure storage account."
  value       = azurerm_storage_account.main.primary_blob_endpoint
}
