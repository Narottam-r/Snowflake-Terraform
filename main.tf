
module "databases" {
  source      = "./modules/databases"
  environment = var.environment
  databases   = var.databases
}

module "warehouses" {
  source     = "./modules/warehouses"
  environment = var.environment
  warehouses  = var.warehouses
}

module "storage_integrations" {
  source                    = "./modules/storage_integrations"
  azure_tenant_id           = var.azure_tenant_id
  storage_allowed_locations = var.storage_allowed_locations
}

module "roles_and_grants" {
  source       = "./modules/roles_and_grants"
  environment  = var.environment
  # Pass the generated database names dynamically from the database module output
  database_ids = module.databases.database_names

  depends_on = [module.databases]
}
