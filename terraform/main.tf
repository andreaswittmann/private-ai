provider "aws" {
  region = var.aws_region
}

# Get the latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Security Group
resource "aws_security_group" "librechat_sg" {
  name        = "LibreChatSecurityGroup"
  description = "Security group for LibreChat deployment"

  # HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ip]
    description = "HTTP access"
  }

  # HTTPS
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ip]
    description = "HTTPS access"
  }

  # Portainer
  ingress {
    from_port   = 9443
    to_port     = 9443
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ip]
    description = "Portainer HTTPS access"
  }

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ip]
    description = "SSH access"
  }

  # Ollama API
  ingress {
    from_port   = 11434
    to_port     = 11434
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ip]
    description = "Ollama API access"
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name        = "LibreChatSecurityGroup"
    Environment = var.environment
    project     = var.project
  }
}

# Update security group to allow SSH
resource "aws_security_group_rule" "allow_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.ssh_cidr_blocks
  security_group_id = aws_security_group.librechat_sg.id
  description       = "Allow SSH access"
}

# IAM Role for EC2 Instance
resource "aws_iam_role" "librechat_role" {
  name = "LibreChatInstanceRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name        = "LibreChatInstanceRole"
    Environment = var.environment
    project     = var.project
  }
}

# Create custom policy for Bedrock
resource "aws_iam_policy" "bedrock_policy" {
  name        = "BedrockModelAccessPolicy"
  description = "Policy for accessing AWS Bedrock models"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "bedrock:InvokeModel",
          "bedrock:InvokeModelWithResponseStream",
          "bedrock:ListFoundationModels",
          "bedrock:GetFoundationModel",
          "bedrock:ListCustomModels",
          "bedrock:GetCustomModel",
          "bedrock:ListModelCustomizationJobs",
          "bedrock:GetModelCustomizationJob"
        ]
        Resource = "*"
      }
    ]
  })

  tags = {
    Name        = "BedrockModelAccessPolicy"
    Environment = var.environment
    project     = var.project
  }
}

# Attach Bedrock policy
resource "aws_iam_role_policy_attachment" "bedrock_policy_attachment" {
  role       = aws_iam_role.librechat_role.name
  policy_arn = aws_iam_policy.bedrock_policy.arn
}

# Create instance profile
resource "aws_iam_instance_profile" "librechat_profile" {
  name = "LibreChatInstanceProfile"
  role = aws_iam_role.librechat_role.name

  tags = {
    Name        = "LibreChatInstanceProfile"
    Environment = var.environment
    project     = var.project
  }
}

# Create an AWS key pair from the provided public key
resource "aws_key_pair" "librechat_keypair" {
  key_name   = "librechat-keypair"
  public_key = var.ssh_public_key
}

# EC2 Instance
resource "aws_instance" "librechat_instance" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.librechat_keypair.key_name
  iam_instance_profile   = aws_iam_instance_profile.librechat_profile.name
  vpc_security_group_ids = [aws_security_group.librechat_sg.id]
  user_data              = file("${path.module}/user_data.sh")

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name        = var.ec2_name
    Environment = var.environment
    project     = var.project
  }
}

# Elastic IP
resource "aws_eip" "librechat_eip" {
  domain = "vpc"
  tags = {
    Name        = "LibreChatEIP"
    Environment = var.environment
    project     = var.project
  }
}

# Associate EIP with EC2 instance
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.librechat_instance.id
  allocation_id = aws_eip.librechat_eip.id
}