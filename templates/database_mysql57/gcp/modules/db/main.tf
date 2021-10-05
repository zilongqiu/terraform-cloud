data "template_file" "default" {
  template = "${file("./modules/db/startup.sh")}"
  vars = {
    mysql_image_name = var.mysql_image_name
    mysql_container_port = var.mysql_container_port
    mysql_container_name = var.mysql_container_name
    mysql_root_password = var.mysql_root_password
    mysql_user_name = var.mysql_user_name
    mysql_user_password = var.mysql_user_password
    mysql_database_name = var.mysql_database_name
  }
}


resource "google_compute_instance" "vm_instance" {
  name         = "vm-test" # (?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?)
  machine_type = "f1-micro"

  tags = ["test-mysql"]

  metadata_startup_script = "${data.template_file.default.rendered}"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-focal-v20210927"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }
}

resource "google_compute_firewall" "rules" {
  name        = "allow-mysql-test"
  network     = "default"
  description = "Creates firewall rule targeting tagged instances"
  target_tags = ["test-mysql"]

  allow {
    protocol  = "tcp"
    ports     = ["3306"]
  }
}