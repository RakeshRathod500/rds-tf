# Fetch existing VPC
data "aws_vpc" "selected" {
  id = var.vpc_id
}

# Fetch subnets in the VPC
data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}

# Create a Security Group for RDS PostgreSQL
resource "aws_security_group" "rds_sg" {
  name        = "rds-postgres-sg"
  description = "Allow PostgreSQL access"
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # <<< RESTRICT THIS TO YOUR IP OR NETWORK CIDR
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-postgres-sg"
  }
}

# RDS Module
module "rds" {
  source = "./modules/rds"

  db_identifier         = var.db_identifier
  db_name               = var.db_name
  db_username           = var.db_username
  db_password           = var.db_password
  db_instance_class     = var.db_instance_class
  allocated_storage     = var.allocated_storage
  engine_version        = var.engine_version

  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  subnet_ids             = data.aws_subnets.selected.ids
}
