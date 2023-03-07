output "default_vpc_id" {
  description = "The ID of the Default VPC"
  value       = try(aws_default_vpc.this[0].id, "")
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public[0].id
}

