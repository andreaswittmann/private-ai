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

output "ssh_connection_command" {
  description = "Command to connect to the instance using SSH"
  value       = "ssh -i ~/.ssh/librechat_key ec2-user@${aws_eip.librechat_eip.public_ip}"
}

output "vscode_remote_connection" {
  description = "Instructions for VS Code Remote SSH connection"
  value       = "Add to ~/.ssh/config: Host librechat-aws\n  HostName ${aws_eip.librechat_eip.public_ip}\n  User ec2-user\n  IdentityFile ~/.ssh/librechat_key"
}

output "librechat_url" {
  description = "URL to access LibreChat"
  value       = "http://${aws_eip.librechat_eip.public_ip}"
}

output "portainer_url" {
  description = "URL to access Portainer"
  value       = "https://${aws_eip.librechat_eip.public_ip}:9443"
}