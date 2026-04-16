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

# Create RDS Instances with the RDS cluster
resource "aws_rds_cluster_instance" "rds_instances" {
  count                = 1
  identifier           = "${var.rds_instance_name}-${count.index}"
  cluster_identifier   = aws_rds_cluster.rds_cluster.id
  instance_class       = "db.r5.large"
  engine               = var.rds_engine
  engine_version       = var.rds_engine_version
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name ##
  publicly_accessible  = true ### 
}