#!/bin/bash
echo "===================================================="
echo " DevOps Environment Setup Script "
echo " Installing Docker | Terraform | Jenkins | Trivy "
echo "===================================================="


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

sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Configure Docker permissions
if ! getent group docker > /dev/null; then
    sudo groupadd docker
fi

# FIXED USER VARIABLE
sudo usermod -aG docker ${SUDO_USER:-$USER}

# --- TERRAFORM INSTALLATION ---
echo "--- Installing Terraform ---"

# FIXED GPG KEY INSTALLATION
curl -fsSL https://apt.releases.hashicorp.com/gpg | \
sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list > /dev/null

sudo apt update -y
sudo apt install terraform -y

# --- TRIVY INSTALLATION ---
echo "--- Installing Trivy ---"

wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | \
sudo gpg --dearmor -o /usr/share/keyrings/trivy.gpg

echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" | \
sudo tee /etc/apt/sources.list.d/trivy.list > /dev/null

sudo apt update -y
sudo apt install -y trivy

# --- JENKINS INSTALLATION ---
echo "--- Installing Jenkins (OpenJDK 21) ---"
sudo apt install -y fontconfig openjdk-21-jre

sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | \
sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update -y
sudo apt install -y jenkins

sudo systemctl enable jenkins
sudo systemctl start jenkins

# Give Jenkins Docker access
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins

# --- FINAL VERIFICATION ---
echo "--------------------------------------"
echo "VERIFYING INSTALLATIONS:"

docker --version
terraform -version
trivy --version
java -version

echo "Jenkins service status:"
systemctl is-active jenkins

echo "--------------------------------------"
echo "SETUP COMPLETE!"
echo "NOTE: Run 'newgrp docker' or log out/in to use Docker without sudo."