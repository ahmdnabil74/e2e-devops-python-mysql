output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane."
  value       = module.eks.cluster_security_group_id
}

############################################
# ECR
############################################

output "ecr_app_repository_name" {
  value = aws_ecr_repository.ecr_repo.name
}

output "ecr_db_repository_name" {
  value = aws_ecr_repository.ecr_repo_2.name
}

############################################
# RDS (FIXED)
############################################

output "rds_endpoint" {
  value = aws_db_instance.rds.endpoint
}
output "rds_port" {
  value = aws_db_instance.rds.port
}

############################################
# DB Credentials
############################################

output "db_username" {
  sensitive = true
  value     = var.db_username
}

output "db_password" {
  sensitive = true
  value     = random_password.password.result
}