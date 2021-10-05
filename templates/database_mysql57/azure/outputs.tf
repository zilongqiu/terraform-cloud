output "instance_id" {
  description = "ID of the compute instance"
  value       = "${module.db.instance_id}"
}

output "instance_public_ip" {
  description = "Public IP address of the compute machine"
  value       = "${module.db.instance_public_ip}"
}