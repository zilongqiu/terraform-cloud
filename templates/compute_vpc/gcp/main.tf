terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.85.0"
    }
  }
}

provider "google" {
  credentials = file(var.gcp_application_credentials)

  project = var.gcp_project_id
  region  = "asia-northeast1" # Tokyo
  zone    = "asia-northeast1-a"
}

module "compute" {
  source = "./modules/compute"
}