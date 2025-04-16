output "rds_endpoint" {
  description = "PostgreSQL RDS endpoint"
  value       = module.rds.endpoint
}
