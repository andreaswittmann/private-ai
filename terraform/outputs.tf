output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.librechat_instance.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_eip.librechat_eip.public_ip
}

output "instance_dns" {
  description = "Public DNS of the EC2 instance"
  value       = aws_instance.librechat_instance.public_dns
}

output "ssm_connection_command" {
  description = "Command to connect to the instance using Session Manager"
  value       = "aws ssm start-session --target ${aws_instance.librechat_instance.id}"
}

output "port_forwarding_command" {
  description = "Command for port forwarding from EC2 to local machine"
  value       = "aws ssm start-session --target ${aws_instance.librechat_instance.id} --document-name AWS-StartPortForwardingSession --parameters \"portNumber=80,localPortNumber=8080\""
}

output "librechat_url" {
  description = "URL to access LibreChat"
  value       = "http://${aws_eip.librechat_eip.public_ip}"
}

output "portainer_url" {
  description = "URL to access Portainer"
  value       = "https://${aws_eip.librechat_eip.public_ip}:9443"
}