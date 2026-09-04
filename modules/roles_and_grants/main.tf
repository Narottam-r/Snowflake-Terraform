# modules/roles_and_grants/main.tf

variable "environment" {
  type = string
}

variable "database_ids" {
  type        = list(string)
  description = "List of database names passed from the database module"
}

locals {
  env = upper(var.environment)
}

resource "snowflake_account_role" "data_engineer" {
  name = "DATA_ENGINEER_${local.env}"
}

resource "snowflake_account_role" "data_analyst" {
  name = "DATA_ANALYST_${local.env}"
}

resource "snowflake_account_role" "data_scientist" {
  name = "DATA_SCIENTIST_${local.env}"
}

resource "snowflake_grant_account_role" "engineer_to_sysadmin" {
  role_name        = snowflake_account_role.data_engineer.name
  parent_role_name = "SYSADMIN"
}

# Dynamically grant USAGE on all deployed databases to the Analyst Role
resource "snowflake_grant_privileges_to_account_role" "analyst_db_usage" {
  for_each          = toset(var.database_ids)
  account_role_name = snowflake_account_role.data_analyst.name
  privileges        = ["USAGE"]

  on_account_object {
    object_type = "DATABASE"
    object_name = each.value
  }
}

