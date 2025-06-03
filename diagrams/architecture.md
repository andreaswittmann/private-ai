# AWS Architecture for LibreChat with AWS Bedrock Integration

## Core Infrastructure Components

### EC2 Instance
- **Instance Type**: t3.medium (2 vCPU, 4 GB RAM) or larger
- **AMI**: Amazon Linux 2023 (most recent version)
- **Placement**: Default VPC in a public subnet with direct internet access
- **User Data**: Optional bootstrap script to install Docker, Docker Compose
- **SSH Access**: Direct SSH connectivity for development and administration

### Storage
- **Root EBS Volume**: gp3, 20GB minimum
  - Enable encryption with default KMS key
  - Delete on termination: true
  - IOPS: 3000 (default)
  - Throughput: 125 MB/s (default)

### Elastic IP Address
- Allocate a new Elastic IP
- Associate with EC2 instance
- Enable EIP transfer lock to prevent accidental release

### IAM Role Configuration
- **Role Name**: LibreChatInstanceRole
- **Policies**:
  - Custom policy for AWS Bedrock:
    ```json
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "bedrock:InvokeModel",
            "bedrock:InvokeModelWithResponseStream"
          ],
          "Resource": "arn:aws:bedrock:*::foundation-model/*"
        }
      ]
    }
    ```

### Security Group
- **Name**: LibreChatSecurityGroup
- **Inbound Rules**:
  - HTTP (80): Your IP Address/32
  - HTTPS (443): Your IP Address/32
  - SSH (22): Your IP Address/32 (for direct access and VS Code Remote)
  - Portainer (9443): Your IP Address/32
  - All other inbound traffic: Denied
- **Outbound Rules**:
  - Allow all traffic to 0.0.0.0/0

## Access and Management

### Direct SSH Access with VS Code Remote Development
- **Primary Access Method**: Direct SSH using key-based authentication
- **VS Code Remote Development**: Connect directly to the instance for development
- **Connection Command**:
  ```bash
  ssh -i ~/.ssh/librechat_key ec2-user@<public-ip>
  ```
- **VS Code Remote SSH**: Use Remote-SSH extension to connect directly to the instance
- **Port Forwarding**: Local port forwarding for development:
  ```bash
  ssh -i ~/.ssh/librechat_key -L 8080:localhost:3080 ec2-user@<public-ip>
  ```

### VS Code Remote Development Integration
- **Extension**: Remote - SSH extension for VS Code
- **Features**:
  - Direct file editing on the remote instance
  - Terminal access within VS Code
  - Port forwarding for local development
  - Extensions running remotely on the instance
- **Setup**: Configure SSH connection in VS Code using the same SSH key
- **Workflow**: Seamless development experience with local IDE connected to remote infrastructure

## Application Layer

### Docker Configuration
- Install Docker Engine and Docker Compose v2
- Configure Docker daemon with recommended production settings:
  - Log rotation
  - Default user namespace remapping
  - systemd control

### Portainer
- Deploy as container on port 9443 (HTTPS)
- Configure with persistent volume for settings
- Enable automatic updates

### LibreChat Deployment
- Deploy via Docker Compose
- Environment configuration for AWS Bedrock integration:
  - AWS_REGION
  - AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY (use instance profile instead)
  - Model configurations for Claude and other supported models
- Configure persistent volumes for MongoDB data
- Expose on ports 80/443 through container mapping

## Integration Points

### AWS Bedrock Configuration
- Ensure Bedrock model access is enabled in your AWS account
- Required models: Claude (Anthropic), others as needed
- IAM role attached to EC2 provides the necessary permissions
- Application uses AWS SDK with instance credentials for secure authentication

This architecture prioritizes simplicity and direct access for development workflows, enabling seamless integration with modern development tools like VS Code Remote SSH, while maintaining security through SSH key-based authentication and appropriate security group restrictions.
