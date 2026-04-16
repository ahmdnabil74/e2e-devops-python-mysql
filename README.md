# 🚀 End-to-End DevOps Python-MySQL Application

## 📌 Overview
This project is a full DevOps implementation for deploying a Python Flask application connected to a MySQL database on AWS.  
It demonstrates a complete CI/CD pipeline, infrastructure as code, containerization, and monitoring in a production-like environment.

---

## 🧱 Architecture
- Python Flask Application (CRUD APIs)
- MySQL Database (AWS RDS)
- Kubernetes (Amazon EKS)
- Docker Containerization
- Terraform for Infrastructure as Code
- CI/CD Pipeline for automated deployment
- Monitoring using Prometheus & Grafana

---

## ☁️ Cloud Infrastructure
- Amazon EKS (Managed Kubernetes Cluster)
- Amazon RDS (MySQL Database)
- Amazon ECR (Docker Image Registry)
- VPC with Multi-AZ setup for high availability

---

## ⚙️ DevOps Workflow
1. Developer pushes code to repository
2. CI pipeline builds Docker image
3. Image is pushed to Amazon ECR
4. Terraform provisions infrastructure
5. Kubernetes (EKS) deploys application
6. Monitoring via Prometheus & Grafana

---

## 🐳 Containerization
The application is containerized using Docker to ensure consistency across environments.

---

## 📊 Monitoring & Observability
- Prometheus: Metrics collection
- Grafana: Visualization dashboards

---

## 💡Key Learnings
1. Designing scalable cloud architectures on AWS
2. Kubernetes deployment and orchestration
3. CI/CD pipeline automation
4. Infrastructure as Code using Terraform
5. Monitoring production-grade systems
