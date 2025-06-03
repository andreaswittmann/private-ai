#!/bin/bash
set -e

# Update system packages
dnf update -y
dnf install -y docker git

# make a nice prompt for ec2-user, append these commands to the ec2-user's ~/.bashrc file
EC2_USER_HOME="/home/ec2-user"
echo "PROMPT_COMMAND=''" >> $EC2_USER_HOME/.bashrc
echo "export PS1=\"\n\[\033[1;32m\]\u@\h\[\033[0m\]:\[\033[1;34m\]\w\[\033[0m\]\$ \"" >> $EC2_USER_HOME/.bashrc
echo "alias ls='ls --color=auto'" >> $EC2_USER_HOME/.bashrc
echo "alias grep='grep --color=auto'" >> $EC2_USER_HOME/.bashrc
# Make sure the ec2-user owns these changes
chown ec2-user:ec2-user $EC2_USER_HOME/.bashrc

# Install Docker
systemctl enable docker
systemctl start docker

# Install Docker Compose v2
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins
curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose

# Configure Docker daemon with production settings
cat > /etc/docker/daemon.json <<EOF
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  },
  "userns-remap": "default"
}
EOF

systemctl restart docker
