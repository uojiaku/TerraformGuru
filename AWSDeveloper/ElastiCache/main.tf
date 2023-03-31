provider "aws" {
  region = "us-east-1"
}


resource "aws_elasticache_replication_group" "eligwe-redis" {
   // num_cache_clusters              = 0
    description                     = "redis eligwe"
    replication_group_id            = "eligwe-redis"
    engine                          = "redis"
    engine_version                  = "6.2"
    node_type                       = "cache.t2.micro"
    parameter_group_name            = "default.redis6.x"
    num_node_groups                 = 0
    replicas_per_node_group         = 0
    port                            = 6379
    automatic_failover_enabled      = false
    multi_az_enabled                = false
    auto_minor_version_upgrade      = true
    apply_immediately               = true
    security_group_ids              = [module.redis_security_group.security_group_id] 
    subnet_group_name               = aws_elasticache_subnet_group.redis.name
    availability_zones              = ["us-east-1a"]
    at_rest_encryption_enabled      = false
    transit_encryption_enabled      = false

}

resource "aws_elasticache_cluster" "eligwe-redis-cluster" {
    count                           = 1
    cluster_id                      = "eligwe-redis" 
    //num_cache_nodes                 = 3
    replication_group_id            = aws_elasticache_replication_group.eligwe-redis.id
}

resource "aws_elasticache_subnet_group" "redis" {
  name       = "redis-subnet"
  subnet_ids = element([data.aws_subnet_ids.example.ids], 0)
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

module "redis_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "eligwe-redis"
  description = "Redis security group"
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