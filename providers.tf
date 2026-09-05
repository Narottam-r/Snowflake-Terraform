# providers.tf
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    snowflake = {
	source  = "snowflakedb/snowflake"
      	version = "2.20.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "snowflake_dev"
    storage_account_name = "snowflakegtrdevadls2"
    container_name       = "gtrdevcontainer"
    key                  = "snowflake/terraform.tfstate"
  }
}

provider "snowflake" {
  organization_name = var.snowflake_organization_name
  account_name      = var.snowflake_account_name
  user              = var.snowflake_user
  authenticator     = "SNOWFLAKE_JWT"
  private_key       = var.snowflake_private_key
  role              = "SYSADMIN"
}

provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
}


