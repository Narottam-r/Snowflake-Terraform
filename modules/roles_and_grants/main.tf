# modules/roles_and_grants/main.tf
variable "environment" {
  type = string
}

locals {
  env = upper(var.environment)
}

# Functional roles
resource "snowflake_account_role" "data_engineer" {
  name = "DATA_ENGINEER_${local.env}"
}

resource "snowflake_account_role" "data_analyst" {
  name = "DATA_ANALYST_${local.env}"
}

resource "snowflake_account_role" "data_scientist" {
  name = "DATA_SCIENTIST_${local.env}"
}

# Role hierarchy
resource "snowflake_grant_account_role" "engineer_to_sysadmin" {
  role_name        = snowflake_account_role.data_engineer.name
  parent_role_name = "SYSADMIN"
}

# Database grants
resource "snowflake_grant_privileges_to_account_role" "analyst_db_usage" {
  account_role_name = snowflake_account_role.data_analyst.name
  privileges        = ["USAGE"]
  on_account_object {
    object_type = "DATABASE"
    object_name = "AZURE_POC_${local.env}"
  }
}
