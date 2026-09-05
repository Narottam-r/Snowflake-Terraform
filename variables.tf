variable "environment" {
  type        = string
  description = "The target deployment environment (DEV, QA, PROD)"
}

# Snowflake Provider Credentials
variable "snowflake_organization_name" {
  type = string
}

variable "snowflake_account_name" {
  type = string
}

variable "snowflake_user" {
  type = string
}

variable "snowflake_private_key" {
  type      = string
  sensitive = true
}

# Azure Configuration
variable "azure_subscription_id" {
  type = string
}

variable "azure_tenant_id" {
  type = string
}

variable "storage_allowed_locations" {
  type = list(string)
}

# Module Complex Maps
variable "databases" {
  type = map(object({
    schemas        = list(string)
    data_retention = number
  }))
}

variable "warehouses" {
  type = map(object({
    size              = string
    auto_suspend      = number
    auto_resume       = bool
    max_cluster_count = number
    min_cluster_count = number
    scaling_policy    = string
    generation        =  string
    enable_query_acceleration = bool
    initially_suspended = bool
  }))
}
