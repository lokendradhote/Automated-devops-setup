🛠️ Automated DevOps Tools Setup

A Bash script that automates the installation and configuration of a complete DevOps toolchain on Ubuntu systems. This project is useful for quickly provisioning AWS EC2 instances or setting up a fresh Ubuntu environment for development.

🚀 Tools Included

Docker Engine & Docker Compose – Containerization platform
Terraform – Infrastructure as Code (IaC)
Jenkins – CI/CD automation server (OpenJDK 21)
Trivy – Vulnerability scanner
Utilities – Git, Curl, Wget, Unzip, GnuPG

📋 Prerequisites

Operating System: Ubuntu 22.04 LTS or newer
Permissions: Sudo/root privileges required
Environment: Cloud (AWS EC2 / Azure / GCP) or local Linux system

⚙️ Installation & Usage

1 Clone the repository

```git clone https://github.com/lokendradhote/Automated-devops-setup
cd Automated-devops-setup
```

2 Grant permission and run the script
```
chmod +x devopstools.sh
sudo ./devopstools.sh
```
3 Apply Docker group changes
```
newgrp docker
```

🛡️ Verification
```
docker --version
terraform -version
trivy --version
java -version
```
Check Jenkins status
```
systemctl status jenkins
```
Access Jenkins in browser:

http://localhost:8080

Get initial Jenkins admin password:
```
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```
Author: Lokendra Dhote  
Portfolio: lokendradhote.vercel.app  
Interests: DevOps, Cloud Computing
