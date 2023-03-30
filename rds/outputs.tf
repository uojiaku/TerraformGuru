output "aws_vpc" {
  description = "vpc subnet"
  value       = data.aws_vpc.default
}

output "ohuru_db" {
  description = "the rds"
  value       = module.ohuru_db
  sensitive   = true
}