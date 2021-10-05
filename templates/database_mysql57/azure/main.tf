terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.78.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.azure_subcription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
}

module "db" {
  source = "./modules/db"
  mysql_image_name = var.mysql_image_name
  mysql_container_port = var.mysql_container_port
  mysql_container_name = var.mysql_container_name
  mysql_root_password = var.mysql_root_password
  mysql_user_name = var.mysql_user_name
  mysql_user_password = var.mysql_user_password
  mysql_database_name = var.mysql_database_name
}