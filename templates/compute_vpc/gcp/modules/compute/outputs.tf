output "instance_id" {
  description = "ID of the compute instance"
  value       = google_compute_instance.vm_instance.instance_id
}

output "instance_public_ip" {
  description = "Public IP address of the compute instance"
  value       = google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip
}