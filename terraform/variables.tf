variable "name_prefix" {
  type    = string
  default = "cluster-1"
}

variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "environment" {
  type    = string
  default = "test"
}

variable "admin_users" {
  type    = list(string)
  default = ["triple-a"]
}

variable "developer_users" {
  type    = list(string)
  default = []
}

variable "main_network_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "asg_sys_instance_types" {
  type    = list(string)
  default = ["m7i-flex.large"]
}

variable "asg_dev_instance_types" {
  type    = list(string)
  default = ["m7i-flex.large"]
}

#####################################
# DB CONFIG
#####################################

variable "db_username" {
  type = string
}

variable "db_name" {
  type    = string
  default = "todo_db"
}

variable "rds_cluster_name" {
  type    = string
  default = "rds-cluster"
}

variable "rds_engine" {
  type    = string
  default = "mysql"
}

variable "rds_engine_version" {
  type    = string
  default = "8.0"
}
variable "rds_instance_name" {
  type    = string
  default = "rds-instance"
}