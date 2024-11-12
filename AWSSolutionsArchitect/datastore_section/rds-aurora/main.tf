provider "aws" {
  profile                 = "awsgoat"
  region                  = "us-east-1"
  shared_credentials_files = ["/Users/ucheojiaku/.aws/credentials"]

}

module "aurora" {
  source  = "terraform-aws-modules/rds-aurora/aws"

  name              = "eligwe-aurora"
  engine            = "aurora-mysql"
  engine_version    = "5.7.mysql_aurora.2.11.1"
  instance_class    = "db.t2.small"
  instances = {
    1 = {
      instance_class            = "db.t2.small"
      identifier                = "otu-1"    // reader instance
      publicly_accessible       = true

    }
    2 = {
      instance_class            = "db.t2.small"
      identifier                = "abuo-2"  // reader instance
      publicly_accessible       = true

    }
    3 = {
      instance_class            = "db.t2.small"
      identifier                = "ato-3"  // writer instance
      publicly_accessible       = true

    }
  }
  master_username   = "admin"
  master_password   = "12345678"   // must be 8 characters or more

  vpc_id  = data.aws_vpc.default.id
  subnets = element([data.aws_subnet_ids.example.ids], 0)
  autoscaling_enabled       = false  // used to be true
  publicly_accessible       = true
  backup_retention_period   = 1
  backtrack_window          = 2  // to disable set to 0
  autoscaling_target_cpu    = 70  // 70%
  autoscaling_min_capacity  = 1
  autoscaling_max_capacity  = 15

  allowed_security_groups = [module.aurora_security_group.security_group_id]
  allowed_cidr_blocks     = ["0.0.0.0/0"]

  storage_encrypted   = true
  apply_immediately   = true
  monitoring_interval = 10

#   db_parameter_group_name         = "default"
#   db_cluster_parameter_group_name = "default"

 
}

################################################################
#################### Supporting Resources ######################

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "example" {
  vpc_id = data.aws_vpc.default.id
}

################################################################
################### Security Group #############################

module "aurora_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "eligwe-aurora"
  description = "Complete MySQL example security group"
  vpc_id      = data.aws_vpc.default.id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "MySQL access from within VPC"
      # cidr_blocks = data.aws_vpc.default.cidr_block
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}