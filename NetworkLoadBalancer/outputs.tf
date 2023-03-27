# output "ec2_instance" {
#   description = "The full output of the `ec2_module` module"
#   value       = module.ec2_instance
# }

# output "instance_id" {
#   description = "EC2 instance ID"
#   value       = [for b in module.ec2_instance : b.id ]
# }

output "my-subnet" {
  description = "my subnets"
  value       = var.subnets
}

output "first_instance" {
  description = "first instance"
  value       = aws_instance.first_instance
}

output "second_instance" {
  description = "second instance"
  value       = aws_instance.second_instance.id
}

output "third_instance" {
  description = "third instance"
  value       = aws_instance.third_instance.id
}

output "az_output" {
  description = "third instance"
  value       = aws_instance.first_instance.subnet_id

}

# output "vpc_subnet" {
#   description = "vpc subnet"
#   value       = data.aws_subnets.example
# }

output "aws_sub" {
  description = "vpc subnet"
  value       = element([data.aws_subnet_ids.example.ids], 0)
}
output "z-alb_security_group" {
  value = module.nlb_security_group
}

output "z-arn-listener" {
  value = module.nlb
}

# output "instance_id_2" {
#   description = "EC2 instance ID"
#   value       =  "${module.ec2_instance.id[0]}"
# }

# output "instance_id_2" {
#   description = "EC2 instance ID"
#   value       = "${module.ec2_instance.id[1]}"
# }

# output "instance_id_3" {
#   description = "EC2 instance ID"
#   value       = "${module.ec2_instance.id[2]}"
# }
