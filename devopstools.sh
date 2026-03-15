#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "--- Updating system and installing basic dependencies ---"
sudo apt update -y
sudo apt install -y git curl wget unzip gnupg software-properties-common ca-certificates lsb-release

# --- DOCKER INSTALLATION ---
echo "--- Installing Docker ---"
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Configure Docker permissions
if ! getent group docker > /dev/null; then
    sudo groupadd docker
fi
sudo usermod -aG docker $USER

# --- TERRAFORM INSTALLATION ---
echo "--- Installing Terraform ---"
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update -y && sudo apt install terraform -y

# --- TRIVY INSTALLATION ---
echo "--- Installing Trivy ---"
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" | sudo tee /etc/apt/sources.list.d/trivy.list
sudo apt update -y && sudo apt install trivy -y

# --- JENKINS INSTALLATION ---
echo "--- Installing Jenkins (OpenJDK 21) ---"
sudo apt install -y fontconfig openjdk-21-jre

sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update -y
sudo apt install -y jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo usermod -aG docker jenkins


# --- FINAL VERIFICATION ---
echo "--------------------------------------"
echo "VERIFYING INSTALLATIONS:"
docker --version
terraform -version
trivy --version
jenkins --version
echo "--------------------------------------"
echo "SETUP COMPLETE!"
echo "NOTE: Run 'newgrp docker' or log out/in to use Docker without sudo."