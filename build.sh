#!/bin/bash
set -e  

# Variables
cluster_name="cluster-1-test"
region="eu-central-1"
aws_id="649126925327"
namespace="todo-app"
monitoring_ns="monitoring"

# ===Terraform
echo "--------------------Terraform Apply--------------------"
cd terraform
terraform init
terraform apply -auto-approve

# اقرأ outputs بعد النجاح
app_img=$(terraform output -raw ecr_app_repository_name)
db_img=$(terraform output -raw ecr_db_repository_name)
rds_endpoint=$(terraform output -raw rds_endpoint)
db_username=$(terraform output -raw db_username)
db_password=$(terraform output -raw db_password)

cd ..

# Validate outputs
if [ -z "$app_img" ] || [ -z "$db_img" ]; then
  echo "Terraform outputs are empty ❌"
  exit 1
fi

# Images
app_image_name="$aws_id.dkr.ecr.$region.amazonaws.com/$app_img:latest"
db_image_name="$aws_id.dkr.ecr.$region.amazonaws.com/$db_img:latest"

echo "APP IMAGE: $app_image_name"
echo "DB IMAGE: $db_image_name"

# Update kubeconfig
echo "--------------------Update Kubeconfig--------------------"
aws eks update-kubeconfig --name $cluster_name --region $region

# Remove old images
echo "--------------------Remove Previous build--------------------"
docker rmi -f $app_image_name 2>/dev/null || true
docker rmi -f $db_image_name 2>/dev/null || true

# Build images
echo "--------------------Build new Image--------------------"
docker build -t $app_image_name todo-app/
docker build -f k8s/Dockerfile.mysql -t $db_image_name k8s/

# Login to ECR
echo "--------------------Login to ECR--------------------"
aws ecr get-login-password --region $region | \
docker login --username AWS --password-stdin $aws_id.dkr.ecr.$region.amazonaws.com

# Push images
echo "--------------------Pushing Docker Image--------------------"
docker push $app_image_name
docker push $db_image_name

# Namespace
echo "--------------------Creating Namespace--------------------"
kubectl create ns $namespace 2>/dev/null || true

# Secrets (fixed)
echo "--------------------Create RDS Secrets--------------------"
kubectl delete secret rds-endpoikubectl create secret generic rds-endpoint \
  --from-literal=endpoint="$rds_endpoint" \
  -n $namespace \
  --dry-run=client -o yaml | kubectl apply -f -nt -n $namespace 2>/dev/null || true
kubectl delete secret rds-username -n $namespace 2>/dev/null || truekubectl create secret generic rds-username \
  --from-literal=username="$db_username" \
  -n $namespace \
  --dry-run=client -o yaml | kubectl apply -f 

kubectl create secret generic rds-password \
  --from-literal=password="$db_password" \
  -n $namespace \
  --dry-run=client -o yaml | kubectl apply -f 
  
kubectl create secret generic rds-endpoint \
  --from-literal=endpoint="$rds_endpoint" \
  -n $namespace

kubectl create secret generic rds-username \
  --from-literal=username="$db_username" \
  -n $namespace

kubectl create secret generic rds-password \
  --from-literal=password="$db_password" \
  -n $namespace

# Deploy
echo "--------------------Deploy App--------------------"
kubectl apply -n $namespace -f k8s/

# Wait
echo "--------------------Wait--------------------"
sleep 60

# URLs
echo "--------------------Application URL--------------------"
kubectl get svc -n $namespace todo-app-service \
  -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'; echo