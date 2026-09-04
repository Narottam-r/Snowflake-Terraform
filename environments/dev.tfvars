# environments/dev.tfvars

environment = "DEV"

# Target Provider Accounts
snowflake_organization_name = "GBLBNOL"
snowflake_account_name      = "ST88491.snowflakecomputing.com"
snowflake_user              = "TF_SERVICE_USER"
# Note: Keep your actual key protected or load via an environment variable TF_VAR_snowflake_private_key
snowflake_private_key       = "-----BEGIN ENCRYPTED PRIVATE KEY-----\nMII...\n-----END ENCRYPTED PRIVATE KEY-----"

azure_subscription_id = "00000000-0000-0000-0000-000000000000"
azure_tenant_id       = "00000000-0000-0000-0000-000000000000"

storage_allowed_locations = [
  "azure://sttargetdatalake.blob.core.windows.net/raw/",
  "azure://sttargetdatalake.blob.core.windows.net/curated/"
]

databases = {
  azure_poc = {
    schemas        = ["raw", "curated", "analytics", "security"]
    data_retention = 1
  }
}

warehouses = {
  etl = {
    size              = "XSMALL"
    auto_suspend      = 60
    auto_resume       = true
    max_cluster_count = 1
    min_cluster_count = 1
    scaling_policy    = "STANDARD"
    GENERATION        =        "1"
    enable_query_acceleration = false
    INITIALLY_SUSPENDED = TRUE

  }
  analytics = {
    size              = "SMALL"
    auto_suspend      = 120
    auto_resume       = true
    max_cluster_count = 3
    min_cluster_count = 1
    scaling_policy    = "STANDARD"
    GENERATION        =        "1"
    enable_query_acceleration = false
    INITIALLY_SUSPENDED = TRUE

  }
}
