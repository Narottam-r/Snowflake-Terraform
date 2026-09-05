# Inside each child module's configuration file
terraform {
  required_providers {
    snowflake = {
      source  = "snowflakedb/snowflake"
      version = ">= 2.20.0" # Match or allow your root module version
    }
  }
}

