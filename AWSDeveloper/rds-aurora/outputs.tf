output "aws_vpc" {
  description = "vpc subnet"
  value       = data.aws_vpc.default
}

output "aurora" {
  description = "the rds"
  value       = module.aurora
  sensitive   = true
}