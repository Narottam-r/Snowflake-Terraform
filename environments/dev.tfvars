# environments/dev.tfvars
environment = "DEV"

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
    generation	      = "1"
    enable_query_acceleration = false
    INITIALLY_SUSPENDED = TRUE

    scaling_policy    = "STANDARD"
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
