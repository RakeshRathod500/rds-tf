variable "db_identifier" {}
variable "db_name" {}
variable "db_username" {}
variable "db_password" {
  sensitive = true
}
variable "db_instance_class" {}
variable "allocated_storage" {}
variable "engine_version" {}
variable "vpc_security_group_ids" {
  type = list(string)
}
variable "subnet_ids" {
  type = list(string)
}
