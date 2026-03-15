# 🛠️ Automated DevOps Tools Setup

A robust Bash script designed to automate the installation and configuration of a professional DevOps toolchain on Ubuntu systems. This is ideal for quickly provisioning **AWS EC2 instances** or setting up a fresh local **Ubuntu** environment for development.

## 🚀 Tools Included
This script automates the setup of the following industry-standard tools:
* **Docker Engine & Docker Compose**: For containerization and orchestration.
* **Terraform**: Infrastructure as Code (IaC) to manage cloud resources.
* **Jenkins**: CI/CD automation server (configured with OpenJDK 21).
* **Trivy**: Security scanner for detecting vulnerabilities in container images and files.
* **Utilities**: Git, Curl, Wget, Unzip, and GnuPG.

## 📋 Prerequisites
* **Operating System**: Ubuntu 22.04 LTS or newer.
* **User Permissions**: Sudo/Root privileges are required to install packages.
* **Environment**: Cloud (EC2/Azure/GCP) or local Linux environments.

## ⚙️ Installation & Usage

### 1. Clone the Repository
```
git clone [https://github.com/YOUR_GITHUB_USERNAME/automated-devops-tools-setup.git](https://github.com/YOUR_GITHUB_USERNAME/automated-devops-tools-setup.git)
cd automated-devops-tools-setup
```
### 2. Grant permissions and Execute
```
chmod +x devopstools.sh
./devopstools.sh
```
### 3. Apply Post-Installation Changes
```
newgrp docker
```
### 🛡️ Verification
Once the script finishes, you can confirm the tools are correctly installed by checking their versions:
```
docker --version
terraform -version
trivy --version
jenkins --version
java -version
```

Author: Lokendra Dhote
Portfolio: lokendradhote.vercel.app  
Interests: DevOps, Cloud Computing, MERN Stack
