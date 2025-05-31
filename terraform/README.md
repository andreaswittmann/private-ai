# Terraform Infrastructure

This directory contains the Infrastructure as Code (IaC) configurations for deploying the LibreChat AWS environment.

## Files (to be migrated in Step 3)

- `main.tf` - Core AWS resource definitions
- `variables.tf` - Input variables and configuration
- `outputs.tf` - Output values for use by other components

The Terraform configuration provisions:
- AWS EC2 instance with appropriate security groups
- IAM roles for AWS Bedrock access
- Elastic IP for stable connectivity
- Security configurations for production deployment
