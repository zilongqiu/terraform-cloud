output "instance_id" {
  description = "ID of the compute instance"
  value       = aws_lightsail_instance.test.id
}

output "instance_public_ip" {
  description = "Public IP address of the compute instance"
  value       = aws_lightsail_instance.test.public_ip_address
}