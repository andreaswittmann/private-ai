# Architecture Diagrams

This directory contains architectural documentation and diagrams for the LibreChat AWS deployment.

## Files

- **`architecture.md`**: Detailed technical architecture documentation
- **`aws-architecture.drawio`**: AWS infrastructure architecture diagram ✅ *Fixed rendering issues*
- **`docker-architecture.drawio`**: Docker container architecture and networking diagram ✅ *Fixed rendering issues*

## Viewing the Diagrams

The `.drawio` files can be viewed and edited in several ways:

1. **Online**: Upload to [diagrams.net](https://app.diagrams.net) (formerly draw.io) ⭐ *Recommended*
2. **GitHub**: GitHub now displays DrawIO files directly in the browser ✅ *Now working correctly*
3. **VS Code**: Install the "Draw.io Integration" extension
4. **Desktop**: Download the desktop app from [diagrams.net](https://www.diagrams.net/)

> **Note**: The diagrams have been fixed to resolve XML formatting issues that previously prevented proper rendering in GitHub and diagrams.net viewers.

## Diagram Contents

### AWS Architecture Diagram (`aws-architecture.drawio`)
- Complete AWS infrastructure layout
- EC2 instance with security groups and IAM roles
- AWS Bedrock integration
- Network topology and access patterns
- Security boundaries and data flow

### Docker Architecture Diagram (`docker-architecture.drawio`)
- Container orchestration with Docker Compose
- Service dependencies and networking
- Port mappings and volume mounts
- Optional RAG/Ollama components
- External API integrations

## Architecture Overview

The LibreChat deployment follows a containerized microservices architecture on AWS:

### Infrastructure Layer (AWS)
- **EC2 Instance**: Single t3.medium instance with Amazon Linux 2023
- **Elastic IP**: Static IP address for consistent access
- **Security Groups**: Network access control for SSH, HTTP/HTTPS
- **IAM Role**: Permissions for AWS Bedrock model access

### Application Layer (Docker)
- **LibreChat**: Main application container (Node.js/React)
- **MongoDB**: Database container for user data and conversations
- **Nginx**: Reverse proxy with SSL termination
- **Ollama** (Optional): Local AI models for RAG embeddings
- **RAG API** (Optional): Document processing and vector search

### AI Integration Layer
- **AWS Bedrock**: Cloud AI models (Claude, Nova, DeepSeek)
- **Local Models**: Ollama-hosted models for privacy-sensitive processing
- **Hybrid Approach**: Cloud reasoning + local embeddings

## Security Architecture

### Network Security
- HTTPS/SSL encryption for all web traffic
- SSH key-based authentication only
- Security groups restrict access to necessary ports
- Optional VPN access for enhanced security

### Data Privacy
- All user data remains on your infrastructure
- Local embedding generation via Ollama
- AWS Bedrock for reasoning (no data retention)
- Self-hosted database and file storage

### Access Control
- IAM roles with least privilege access
- SSM Session Manager for secure shell access
- Container isolation and networking
- Environment variable protection

## Deployment Patterns

### Development Setup
- HTTP access on port 3080
- Local Docker Compose deployment
- Basic SSL with self-signed certificates

### Production Setup
- HTTPS with proper SSL certificates
- Nginx reverse proxy with security headers
- Persistent volumes for data retention
- Resource optimization and monitoring

## Scalability Considerations

### Vertical Scaling
- Instance type upgrades (t3.medium → t3.large → t3.xlarge)
- Storage expansion (EBS volume resizing)
- Memory allocation for containers

### Horizontal Scaling (Future)
- Load balancer for multiple instances
- Shared database (RDS MongoDB-compatible)
- Container orchestration (ECS/EKS)

This architecture prioritizes privacy, security, and reproducibility while maintaining simplicity for self-hosting scenarios.
