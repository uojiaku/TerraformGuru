output "ec2_instance" {
  description = "The full output of the `ec2_module` module"
  value       = module.create_ec2_instance
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = [for b in module.create_ec2_instance : b.id ]
}


output "aws_sub" {
  description = "vpc subnet"
  value       = element([data.aws_subnet_ids.example.ids], 0)
}

