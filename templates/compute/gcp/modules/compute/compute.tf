resource "google_compute_instance" "vm_instance" {
  name         = "vm-${random_id.instance_id.hex}" # (?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?)
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }
}