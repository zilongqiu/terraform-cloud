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

module "compute" {
  source = "./modules/compute"
}