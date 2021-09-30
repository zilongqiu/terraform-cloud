# 1. Compute Network
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network
resource "google_compute_network" "vpc_network" {
  name = "vpc-network"
}

# 2. Create instance
data "google_compute_image" "debian_image" {
  family  = "debian-9"
  project = "debian-cloud"
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_instance
resource "google_compute_instance" "vm_instance" {
  name         = "hello-world" # (?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?)
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = data.google_compute_image.debian_image.self_link
    }
  }

  tags = ["web"]

  network_interface {
    network = google_compute_network.vpc_network.id
    access_config {
    }
  }
}

# 3. Create instance group
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance_group
resource "google_compute_instance_group" "webservers" {
  name        = "terraform-webservers"
  zone        = "asia-northeast1-a"
  description = "Terraform test instance group"
  network     = google_compute_network.vpc_network.id

  instances = [
    google_compute_instance.vm_instance.id,
  ]

  named_port {
    name = "http"
    port = "80"
  }

  named_port {
    name = "https"
    port = "8443"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# 4. Create Backend Service
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_backend_service
resource "google_compute_backend_service" "staging_service" {
  name      = "staging-service"
  port_name = "https"
  protocol  = "HTTPS"

  backend {
    group = google_compute_instance_group.webservers.id
  }

  health_checks = [
    google_compute_https_health_check.staging_health.id,
  ]
}

# 5. Create Health Check
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_http_health_check
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_https_health_check
resource "google_compute_https_health_check" "staging_health" {
  name         = "staging-health"
  request_path = "/health_check"
}

# 6. Create Firewall Rules
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall#example-usage---firewall-with-target-tags
resource "google_compute_firewall" "custom-rules" {
  name        = "my-firewall-rule"
  network     = google_compute_network.vpc_network.id
  description = "Creates firewall rule targeting tagged instances"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol  = "tcp"
    ports     = ["22", "80", "8080", "8443", "1000-2000"]
  }

  target_tags = ["web"]
}