
output "database_names" {
  value       = module.databases.database_names
  description = "List of created databases"
}

output "storage_integration_name" {
  value       = module.storage_integrations.integration_name
  description = "Name of the storage integration"
}
