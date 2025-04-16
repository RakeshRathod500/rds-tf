resource "aws_db_instance" "postgres" {
  identifier             = var.db_identifier
  engine                 = "postgres"
  engine_version         = var.engine_version
  instance_class         = var.db_instance_class
  db_name                   = var.db_name
  username               = var.db_username
  password               = var.db_password
  allocated_storage      = var.allocated_storage

  db_subnet_group_name   = aws_db_subnet_group.postgres.name
  vpc_security_group_ids = var.vpc_security_group_ids

  skip_final_snapshot    = true
  publicly_accessible    = true
}

resource "aws_db_subnet_group" "postgres" {
  name       = "${var.db_identifier}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "Postgres subnet group"
  }
}
