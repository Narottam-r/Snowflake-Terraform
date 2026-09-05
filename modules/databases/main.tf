# modules/databases/main.tf
# Inside each child module's configuration file
terraform {
  required_providers {
    snowflake = {
      source  = "snowflakedb/snowflake"
      version = ">= 2.20.0" # Match or allow your root module version
    }
  }
}

variable "environment" {
  type = string
}

variable "databases" {
  type = map(object({
    schemas          = list(string)
    data_retention   = number
  }))
}

resource "snowflake_database" "db" {
  for_each                    = var.databases
  name                        = upper("${each.key}_${var.environment}")
  data_retention_time_in_days = each.value.data_retention
}

resource "snowflake_schema" "schema" {
  for_each = { for pair in flatten([
    for db_key, db in var.databases : [
      for schema in db.schemas : {
        key    = "${db_key}_${schema}"
        db     = upper("${db_key}_${var.environment}")
        schema = upper(schema)
      }
    ]
  ]) : pair.key => pair }

  database = each.value.db
  name     = each.value.schema

  depends_on = [snowflake_database.db]
}
