module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = "eligwe-alb"

  load_balancer_type = "application"

  vpc_id             = data.aws_vpc.default.id
  subnets            = data.aws_subnet.default.name
  security_groups    = [module.security_group.security_group_id]


  target_groups = [
    {
      name_prefix      = "pref-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      targets = {
        my_target = {
          target_id = data.aws_lb_target_group.test.id
          port = 80
        }
      }
    }
  ]


  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = {
    Environment = "Test"
  }
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "alb-security_group"
  description = "Security group for example usage with EC2 instance"
  # vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "ssh-tcp", "all-icmp"]
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


// Create Instance Target group

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "default" {
  default = true
}

# creates target group
resource "aws_lb_target_group" "test" {
  name     = "eligwe-alb"
  port     = 80
  protocol = "HTTP"
  vpc_id   =  data.aws_vpc.default.id
}

# attaches instances to target group
resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = each.value.id
  port             = 80
}

