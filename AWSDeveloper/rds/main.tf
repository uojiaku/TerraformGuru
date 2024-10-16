provider "aws" {
  profile                 = "awsgoat"
  region                  = "us-east-1"
  shared_credentials_files = ["/Users/ucheojiaku/.aws/credentials"]
}


module "ohuru_db" {
  source  = "terraform-aws-modules/rds/aws"

  identifier = "eligwedb"

  engine               = "mysql"
  engine_version       = "8.0.39"
  instance_class       = "db.t4g.micro"
  family               = "mysql8.0"
  major_engine_version = "8.0"

  db_name              = "eligwedb"
  username             = "admin"
  password             = "12345"
  port                 = "3306"
  storage_type         = "gp2"
  allocated_storage    = "10"

  iam_database_authentication_enabled = false // changed to false

  vpc_security_group_ids = [module.rds_security_group.security_group_id]

  # maintenance_window = "Mon:00:00-Mon:03:00"
  # backup_window      = "03:00-06:00"
  auto_minor_version_upgrade        = true
  deletion_protection               = false // changed to false
  enabled_cloudwatch_logs_exports   = []
  backup_retention_period           = "7"
  backup_window                     = null
  publicly_accessible               = true
  max_allocated_storage             = 1000
  storage_encrypted                 = false

  tags = {
    Owner       = "user"
    Environment = "dev"
  }

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = element([data.aws_subnets.example.ids], 0)

}

################################################################
#################### Supporting Resources ######################

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "example" {
  # vpc_id = data.aws_vpc.default.id
}

################################################################
################### Security Group #############################

module "rds_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "eligwe-rds"
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