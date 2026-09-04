# modules/storage_integrations/main.tf
variable "azure_tenant_id" {
  type = string
}

variable "storage_allowed_locations" {
  type = list(string)
}

resource "snowflake_storage_integration" "azure_adls" {
  name                      = "AZURE_ADLS_INT"
  type                      = "EXTERNAL_STAGE"
  storage_provider           = "AZURE"
  enabled                   = true
  azure_tenant_id           = var.azure_tenant_id
  storage_allowed_locations = var.storage_allowed_locations
}
