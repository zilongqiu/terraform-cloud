output "instance_id" {
  description = "ID of the compute instance"
  value       = aws_instance.my-first-server.id
}

output "instance_public_ip" {
  description = "Public IP address of the compute instance"
  value       = aws_instance.my-first-server.public_ip
}