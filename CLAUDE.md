# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **privacy-focused AI deployment project** demonstrating self-hosted LibreChat with AWS Bedrock integration using live-scripting methodology. The project creates a complete, executable workflow for deploying a private AI system with full data control.

## Architecture

### Core Components
- **LibreChat**: Self-hosted AI chat interface deployed via Docker Compose
- **AWS Bedrock Integration**: Multiple AI models (Claude, Nova, DeepSeek) with IAM-based authentication
- **Infrastructure as Code**: Terraform automation for AWS EC2 deployment with security groups and IAM roles
- **RAG Capabilities**: Ollama integration for document processing and embeddings
- **Production Setup**: SSL/HTTPS with NGINX reverse proxy, MongoDB persistence

### Live-Scripting Methodology
The primary workflow is in `librechat-aws-deployment.org` using F4 execution in Emacs with vterm, though all commands work via copy-paste in any terminal.

## Key Files and Structure

### Primary Workflow
- `librechat-aws-deployment.org` - Complete interactive deployment workflow with live-scripting capabilities
- `librechat-aws-deployment.html` - Styled HTML version for web viewing

### Infrastructure
- `terraform/main.tf` - AWS resource definitions (EC2, security groups, IAM roles, Elastic IP)
- `terraform/variables.tf` - Configuration parameters
- `terraform/outputs.tf` - Instance details and connection information

### Application Configuration
- `configs/deploy-compose.yml` - Docker Compose for LibreChat, MongoDB, NGINX, and RAG services
- `configs/nginx.conf` - NGINX reverse proxy configuration with SSL
- `configs/docker-compose.override.yml.ollama` - Ollama integration for RAG capabilities

### Architecture Documentation
- `diagrams/aws-architecture.drawio` - AWS infrastructure architecture diagram
- `diagrams/docker-architecture.drawio` - Container architecture diagram
- `diagrams/architecture.md` - Detailed architecture documentation

## Common Commands

### Terraform Infrastructure Deployment
```bash
cd terraform/
terraform init
terraform plan -out=tfplan
terraform apply tfplan
```

### Project Environment Setup
```bash
PROJECT_DIR="/Users/$(whoami)/LocalProjects/ai-bootcamp/private-ai"
cd "$PROJECT_DIR"
export AWS_PROFILE=lab-a  # Adjust for your AWS profile
```

### AWS Environment Validation
```bash
aws sts get-caller-identity
aws bedrock list-foundation-models --region us-east-1
```

### Docker Deployment on EC2
```bash
# After SSH/SSM connection to EC2 instance
sudo yum update -y
sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -a -G docker ec2-user

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

### LibreChat Deployment
```bash
# Deploy LibreChat stack
docker-compose -f deploy-compose.yml up -d

# Monitor logs
docker-compose -f deploy-compose.yml logs -f

# Check service status
docker-compose -f deploy-compose.yml ps
```

## Development Workflow

### Live-Scripting Execution (Emacs)
1. Open `librechat-aws-deployment.org` in Emacs with vterm side-by-side
2. Use F4 (`send-line-to-vterm`) to execute commands line by line
3. Follow checkpoints and validation steps throughout the workflow

### Copy-Paste Alternative
1. Open `librechat-aws-deployment.org` in any text editor
2. Copy command blocks and paste into terminal
3. Maintain consistent terminal session throughout deployment

## AWS Bedrock Configuration

### Required AWS Setup
- Bedrock model access enabled for Claude, Nova, DeepSeek models
- IAM role with `bedrock:InvokeModel` and `bedrock:InvokeModelWithResponseStream` permissions
- EC2 instance profile for secure authentication

### Model Testing
```bash
# Test Bedrock model access
aws bedrock invoke-model \
  --model-id anthropic.claude-3-sonnet-20240229-v1:0 \
  --body '{"messages":[{"role":"user","content":"Hello"}],"max_tokens":100}' \
  --region us-east-1 output.json
```

## Security Considerations

### Network Security
- Security groups restrict access to necessary ports (22, 80, 443, 3080)
- SSH access via key authentication only
- Optional: IP address restrictions for production deployments

### Data Privacy
- All conversations stored locally in MongoDB
- No data sent to external services except chosen Bedrock models
- Instance-based IAM authentication (no hardcoded credentials)

## Project Status

Currently at **Step 3.5**: Diagram Architecture Updates
- Repository structure and configuration migration completed
- DrawIO diagrams restored and functional
- Next: Update diagrams to reflect current deployment architecture

The project demonstrates a foundational privacy-focused AI system ready for production enhancement with scaling, high availability, and enterprise features.