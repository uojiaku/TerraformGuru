output "s3bucket8" {
  description = "the s3"
  value       = module.s3_bucket8
  sensitive   = true
}

output "distribution" {
  description = "the distribution"
  value       = resource.aws_cloudfront_distribution.this2
  sensitive   = true
}

output "origin_access_control" {
  description = "the OAC"
  value       = resource.aws_cloudfront_origin_access_control.this2
  sensitive   = true
}

