# Configuration Files

This directory contains all configuration files needed for the LibreChat deployment.

## Docker Configuration Files

### Core Deployment Files
- **`deploy-compose.yml`**: Production Docker Compose configuration with SSL/HTTPS support
- **`docker-compose.override.yml`**: Development override for basic LibreChat deployment
- **`docker-compose.override.yml.ollama`**: Override file that includes Ollama for RAG functionality

### Web Server Configuration
- **`nginx.conf`**: Nginx reverse proxy configuration with SSL termination and security headers

### Environment Configuration
- **`.env.example`**: Template environment file with all configuration options documented

## Usage

### Basic LibreChat Deployment
```bash
# Copy to LibreChat directory and use with deploy-compose.yml
cp docker-compose.override.yml ~/LibreChat/
cp deploy-compose.yml ~/LibreChat/
cp nginx.conf ~/LibreChat/client/
```

### With RAG (Ollama) Support
```bash
# Use the Ollama-specific override instead
cp docker-compose.override.yml.ollama ~/LibreChat/docker-compose.override.yml
```

### Environment Setup
```bash
# Copy and customize environment variables
cp .env.example ~/LibreChat/.env
# Edit .env with your AWS credentials and model preferences
```

## File Descriptions

### deploy-compose.yml
- Configures LibreChat for production deployment
- Includes SSL certificate mounting
- Sets up persistent volumes for MongoDB and application data
- Configured for HTTPS on port 443

### docker-compose.override.yml
- Basic development configuration
- HTTP access on port 3080
- Minimal resource requirements

### docker-compose.override.yml.ollama
- Includes Ollama container for local AI model serving
- RAG API container for document processing
- Additional volumes for model storage
- Network configuration for inter-container communication

### nginx.conf
- SSL/TLS configuration with security headers
- Reverse proxy setup for LibreChat backend
- Static file serving optimization
- Security-focused headers (HSTS, CSP, etc.)

### .env.example
- AWS Bedrock model configurations
- Database connection settings
- Security and authentication options
- RAG and embedding model settings

## Security Features

- SSL/HTTPS encryption
- Security headers in Nginx
- Environment variable protection
- Isolated container networking

These configurations are designed to be:
- Production-ready with security considerations
- Portable across different deployment environments
- Compatible with the live-scripting workflow
