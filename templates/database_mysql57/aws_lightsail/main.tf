terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1" # Tokyo
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
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