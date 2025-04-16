variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "vpc_id" {
  description = "ID of the existing VPC"
  type        = string
}

variable "db_identifier" {}
variable "db_name" {}
variable "db_username" {}
variable "db_password" {
  sensitive = true
}
variable "db_instance_class" {}
variable "allocated_storage" {}
variable "engine_version" {}
