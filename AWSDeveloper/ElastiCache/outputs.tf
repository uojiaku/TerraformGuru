output "aws_vpc" {
  description = "vpc subnet"
  value       = data.aws_vpc.default
}

output "elasticCache" {
  description = "the redis cache"
  value       = aws_elasticache_replication_group.eligwe-redis
  sensitive = true
}

output "elastiCache" {
  description = "the redis cluster"
  value       = aws_elasticache_cluster.eligwe-redis-cluster
  sensitive = true
}