# Create RDS Cluster
resource "aws_db_instance" "rds" {
  identifier        = var.rds_instance_name
  allocated_storage = 20

  engine            = var.rds_engine        # mysql
  engine_version    = var.rds_engine_version # 8.0

  instance_class    = "db.t3.micro"

  db_name           = var.db_name
  username          = var.db_username
  password          = random_password.password.result

  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name

  skip_final_snapshot = true
  publicly_accessible = true

  tags = {
    Name = var.rds_instance_name
  }
}

