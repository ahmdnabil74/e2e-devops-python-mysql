🚀 End-to-End DevOps Python-MySQL Application
📌 Overview

This project is a full DevOps implementation for deploying a Python Flask application connected to a MySQL database on AWS.
It demonstrates a complete CI/CD pipeline, infrastructure as code, containerization, and monitoring in a production-like environment.

🧱 Architecture
Python Flask Application (CRUD APIs)
MySQL Database (AWS RDS)
Kubernetes (Amazon EKS)
Docker Containerization
Terraform for Infrastructure as Code
CI/CD Pipeline for automated deployment
Monitoring using Prometheus & Grafana
☁️ Cloud Infrastructure
Amazon EKS (Managed Kubernetes Cluster)
Amazon RDS (MySQL Database)
Amazon ECR (Docker Image Registry)
VPC with Multi-AZ setup for high availability
⚙️ DevOps Workflow
Developer pushes code to repository
CI pipeline builds Docker image
Image is pushed to Amazon ECR
Terraform provisions infrastructure
Kubernetes (EKS) deploys application
Monitoring via Prometheus & Grafana
🐳 Containerization

The application is containerized using Docker to ensure consistency across environments.

📊 Monitoring & Observability
Prometheus: Metrics collection
Grafana: Visualization dashboards
🚀 How to Run (Locally)
# Clone repo
git clone https://github.com/your-repo-link
cd project-folder

# Build Docker image
docker build -t flask-app .

# Run container
docker run -p 5000:5000 flask-app
☸️ Deployment (AWS EKS)
# Terraform apply
terraform init
terraform apply

# Deploy to Kubernetes
kubectl apply -f k8s/
💡 Key Learnings
Designing scalable cloud architectures on AWS
Kubernetes deployment and management
CI/CD automation best practices
Infrastructure as Code using Terraform
Monitoring production systems
