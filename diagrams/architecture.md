# AWS Architecture for LibreChat with AWS Bedrock Integration

## Core Infrastructure Components

### EC2 Instance
- **Instance Type**: t3.medium (2 vCPU, 4 GB RAM) or larger
- **AMI**: Amazon Linux 2023 (most recent version with SSM Agent pre-installed)
- **Placement**: Default VPC in a public subnet
- **User Data**: Optional bootstrap script to install Docker, Docker Compose

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
  - `AmazonSSMManagedInstanceCore` (for SSM Session Manager access)
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
  - Portainer (9443): Your IP Address/32
  - All other inbound traffic: Denied
- **Outbound Rules**:
  - Allow all traffic to 0.0.0.0/0

## Access and Management

### Systems Manager Session Manager
- No inbound SSH port required
- Access via AWS Console → Systems Manager → Session Manager
- Port forwarding command for local development:
  ```
  aws ssm start-session --target i-instanceid --document-name AWS-StartPortForwardingSession --parameters "portNumber=80,localPortNumber=8080"
  ```

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

This architecture prioritizes simplicity for a lab environment while maintaining security through SSM access and appropriate IAM permissions, with the stability of a fixed IP address via Elastic IP.
