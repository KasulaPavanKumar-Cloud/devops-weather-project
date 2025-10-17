#!/bin/bash
set -e

# update
apt-get update -y

# install basic packages
apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release software-properties-common

# Docker install
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io

# Add ubuntu user to docker group (default user is ubuntu)
usermod -aG docker ubuntu || true

# Install Git
apt-get install -y git

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

# Install docker-compose (if needed later)
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Allow some time
sleep 5

# mark done
echo "user-data finished" > /home/ubuntu/userdata_done.txt
chown ubuntu:ubuntu /home/ubuntu/userdata_done.txt
