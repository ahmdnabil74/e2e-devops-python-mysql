
# Generate random DB password
resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

# Add random suffix to avoid secret name conflicts
resource "random_id" "secret_suffix" {
  byte_length = 4
}

# Create Secret in AWS Secrets Manager
resource "aws_secretsmanager_secret" "rds_credentials" {
  name                    = "${var.rds_instance_name}-secrets-${random_id.secret_suffix.hex}"
  description             = "RDS DB credentials"
  recovery_window_in_days = 0
}

# Store username & password in the secret
resource "aws_secretsmanager_secret_version" "rds_credentials_version" {
  secret_id = aws_secretsmanager_secret.rds_credentials.id

  secret_string = jsonencode({
    username = var.db_username
    password = random_password.password.result
  })
}

/*
resource "random_password" "password" {
     length = 16 
     special = true 
     override_special = "_%@"
} 

resource "aws_secretsmanager_secret" "rds_credentials" {
    name = "${var.rds_cluster_name}-secrets-4" 
    description = "RDS DB credentials" 
} 

# Set the values of the secrets in the Secret manager resource 
resource "aws_secretsmanager_secret_version" "rds_credentials_version" {
    secret_id = aws_secretsmanager_secret.rds_credentials.id 
    secret_string = jsonencode({
        "username" : var.db_username,
        "password" : random_password.password.result 
    }) 
}   
*/