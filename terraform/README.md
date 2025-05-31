# Terraform Infrastructure

This directory contains the Infrastructure as Code (IaC) configurations for deploying the LibreChat AWS environment.

## Files

- `main.tf` - Core AWS resource definitions including EC2, VPC, security groups, and IAM roles
- `variables.tf` - Input variables and configuration parameters
- `outputs.tf` - Output values including instance IP, SSH commands, and connection details

## Infrastructure Components

The Terraform configuration provisions:

### Core Resources
- **EC2 Instance**: t3.medium (configurable) with Amazon Linux 2023
- **Elastic IP**: Static IP address for consistent access
- **Security Group**: Configured for SSH (22), HTTP (80), HTTPS (443), and LibreChat (3080)
- **IAM Role & Instance Profile**: EC2 instance permissions for AWS Bedrock access

### Network Configuration
- Uses default VPC and public subnet
- Security group allows inbound traffic on required ports
- SSH access restricted to specified CIDR blocks

### Bedrock Integration
- IAM role with permissions for AWS Bedrock model access
- Supports Claude, Nova, and DeepSeek models
- Instance profile attached for seamless AWS SDK authentication

## Usage

1. **Initialize Terraform**:
   ```bash
   terraform init
   ```

2. **Create terraform.tfvars**:
   ```bash
   aws_region       = "eu-central-1"
   instance_type    = "t3.medium"
   root_volume_size = 30
   ssh_public_key   = "your-ssh-public-key"
   ec2_name         = "EC2-LibreChat"
   environment      = "development"
   project          = "private-ai"
   ```

3. **Plan and Apply**:
   ```bash
   terraform plan -out=tfplan
   terraform apply tfplan
   ```

## Outputs

After successful deployment, Terraform provides:
- Public IP address for SSH and web access
- Instance ID for AWS CLI operations
- SSH connection command for easy access

## Security Considerations

- SSH key authentication required
- Security groups limit access to necessary ports
- IAM role follows principle of least privilege
- Optional: Restrict SSH access to specific IP ranges

The Terraform configuration provisions:
- AWS EC2 instance with appropriate security groups
- IAM roles for AWS Bedrock access
- Elastic IP for stable connectivity
- Security configurations for production deployment
