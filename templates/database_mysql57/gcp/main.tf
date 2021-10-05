terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.85.0"
    }
    template = {
      source = "hashicorp/template"
      version = "2.2.0"
    }
  }
}

provider "google" {
  credentials = file(var.gcp_application_credentials)

  project = var.gcp_project_id
  region  = "asia-northeast1" # Tokyo
  zone    = "asia-northeast1-a"
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