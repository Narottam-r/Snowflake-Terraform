# modules/warehouses/main.tf
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

variable "warehouses" {
  type = map(object({
    size              = string
    auto_suspend      = number
    auto_resume       = bool
    max_cluster_count = number
    min_cluster_count = number
    scaling_policy    = string
    GENERATION =  string
    enable_query_acceleration = bool
  INITIALLY_SUSPENDED = bool
  }))
}

resource "snowflake_warehouse" "wh" {
  for_each           = var.warehouses
  name               = upper("${each.key}_${var.environment}_WH")
  warehouse_size     = each.value.size
  auto_suspend       = each.value.auto_suspend
  auto_resume        = each.value.auto_resume
  max_cluster_count  = each.value.max_cluster_count
  min_cluster_count  = each.value.min_cluster_count
  scaling_policy     = each.value.scaling_policy
  GENERATION         = each.value.GENERATION
  enable_query_acceleration = each.value.enable_query_acceleration
  initially_suspended = true
}
