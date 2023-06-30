

provider "aws" {
  region = "us-east-1"
}

resource "aws_ecs_task_definition" "nginx" {
  family                   = "nginxdemo"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 2048
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "nginxd",
    "image": "nginxdemos/hello",
    "cpu": 512,
    "container_port" : "80",
    "protocol" : "TCP",
    "memory": 1024,
    "essential": true
  }
]
TASK_DEFINITION

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}

################# Instances Security Group ######################
module "cidr_block_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "cidr-block-group"
  description = "Security group with cidr!!!"
  # vpc_id      = module.vpc.vpc_id


  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["all-all"]
  # ingress_rules       = ["http-80-tcp", "ssh-tcp", "all-icmp"] // old
  # egress_rules        = ["all-all"]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Open internet I think"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = local.tags
}


#################### ALB Security Group #####################
resource "aws_security_group_rule" "inbound_http" {
  type            = "ingress"
  from_port       = 0
  to_port         = 65535
  protocol        = "tcp"
  source_security_group_id = module.alb_security_group.security_group_1_id

  # security_group_id = module.instance_security_group.security_group_id
}

resource "aws_security_group_rule" "outbound_http" {
  type            = "egress"
  from_port       = 0
  to_port         = 65535
  protocol        = "tcp"
  # source_security_group_id =  module.instance_security_group.security_group_id

  security_group_id = module.alb_security_group.security_group_1_id
}