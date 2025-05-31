variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "eu-central-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.medium"
}

variable "root_volume_size" {
  description = "Size of the root EBS volume in GB"
  type        = number
  default     = 30 // Changed from 20 to 30 to meet minimum requirements
}

variable "root_volume_type" {
  description = "Type of the root EBS volume"
  type        = string
  default     = "gp3"
}

variable "allowed_ip" {
  description = "IP address allowed to access the instance"
  type        = string
  default     = "0.0.0.0/0" # Replace with your IP in production
}

variable "ec2_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "LibreChat-Instance"
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "development"
}

variable "project" {
  description = "Project tag to be applied to all resources"
  type        = string
  default     = "private-ai"
}


variable "ssh_public_key" {
  type        = string
  description = "SSH public key for EC2 instance access"
}

variable "ssh_cidr_blocks" {
  description = "CIDR blocks allowed for SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"] # Warning: This allows SSH from anywhere. Restrict this in production.
}