
locals {
  name   = "ezigbo"
  region = "us-east-1"

  user_data = <<EOT
  #!/bin/bash
  # Use this for your user data (script from top to bottom)
  # install httpd (Linux 2 version)
  yum update -y
  yum install -y httpd
  systemctl start httpd
  systemctl enable httpd
  echo "<h1>Hello world from $(hostname -f) </h1>" > /var/www/html/index.html
  EOT

  tags = {
    Owner       = "ec2-user"
    Environment = "dev"
  }
  production_availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

}

##################################################################
##################### AutoScaling Group ##########################

module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  name = "ezigbo-asg"

  min_size                  = 1
  max_size                  = 5
  desired_capacity          = 4
  wait_for_capacity_timeout = 0
  health_check_type         = "ELB" // or EC2
  vpc_zone_identifier       = element([data.aws_subnet_ids.example.ids], 0)
  target_group_arns         = module.asg_alb.target_group_arns
  protect_from_scale_in     = true


  # Launch template
  launch_template_name        = "ezigbo-launch-template"
  launch_template_description = "Launch template for Ezigbo ASG"
  update_default_version      = true

  image_id                    = data.aws_ami.amazon-linux-2.id
  instance_type               = "t2.micro"
  ebs_optimized               = false
  enable_monitoring           = false
  security_groups             = [module.asg_security_group.security_group_id]
  key_name                    = "tf-key-pair-4"
  
   block_device_mappings = [
    {
      # Root volume
      device_name = "/dev/xvda"
      no_device   = 0
      ebs = {
        delete_on_termination = true
        encrypted             = true
        volume_size           = 9
        volume_type           = "gp2"
      }
    }, {
      device_name = "/dev/sda1"
      no_device   = 1
      ebs = {
        delete_on_termination = true
        encrypted             = true
        volume_size           = 8
        volume_type           = "gp2"
      }
    }
  ]

  placement = {
    availability_zone = "us-east-1a"
  }

  tag_specifications = [
    {
      resource_type = "instance"
      tags          = { WhatAmI = "Instance" }
    },
    {
      resource_type = "volume"
      tags          = { WhatAmI = "Volume" }
    },
    
  ]

}

##################### Supporting Resources ########################

# amazon linux 2
data "aws_ami" "amazon-linux-2" {
 most_recent = true


 filter {
   name   = "owner-alias"
   values = ["amazon"]
 }


 filter {
   name   = "name"
   values = ["amzn2-ami-hvm*"]
 }
}

## create key pair 
resource "aws_key_pair" "tf-key-pair-4" {
    key_name = "tf-key-pair-4"
    public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "local_file" "tf-key" {
    content = tls_private_key.rsa.private_key_pem
    filename = "tf-key-pair-4"
}

# placement group
resource "aws_placement_group" "web" {
  name     = local.name
  strategy = "cluster"
}

#############################################################
#################### ASG Security Group #####################
module "asg_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "asg-security-group"
  description = "Security group for ASG!!"
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

#############################################################
########## Application Load Balancer Section ################



################################################################################
############################ EC2 Instances #####################################
################################################################################

resource "aws_instance" "asg_first_instance" {
  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = var.instance_type
  availability_zone      = element(local.production_availability_zones, 0)
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [module.asg_instance_security_group.security_group_id]
  key_name               = "tf-key-pair-4"


  root_block_device {
          encrypted   = true
          volume_type = "gp2"
          volume_size = 50
        }
      
  tags = { Name = "Ezigbo_1"}

 }

########################## EC2 instance 2 #####################################

resource "aws_instance" "asg_second_instance" {
  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = var.instance_type
  availability_zone      = element(local.production_availability_zones, 1) 
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [module.asg_instance_security_group.security_group_id]
  key_name               = "tf-key-pair-4"


  root_block_device {
          encrypted   = true
          volume_type = "gp2"
          volume_size = 50
        }
      
  tags = { Name = "Ezigbo_2"} 
}

########################## EC2 instance 3 #####################################

resource "aws_instance" "asg_third_instance" {
  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = var.instance_type
  availability_zone      = element(local.production_availability_zones, 2) 
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [module.asg_instance_security_group.security_group_id]
  key_name               = "tf-key-pair-4"


  root_block_device  {
          encrypted   = true
          volume_type = "gp2"
          volume_size = 50
        }

   tags = { Name = "Ezigbo_3"} 

}
################################################################################
# Supporting Resources
################################################################################

# module "vpc" {
#   source  = "terraform-aws-modules/vpc/aws"
#   version = "~> 3.0"

#   name = local.name
#   cidr = "10.99.0.0/18"
#   # cidr = "${var.vpc_cidr}"

#   # azs              = ["${local.region}a", "${local.region}b"]
#   # public_subnets   = ["10.99.0.0/24", "10.99.1.0/24"]
#   # private_subnets  = ["10.99.3.0/24", "10.99.4.0/24"]
#   # database_subnets = ["10.99.7.0/24", "10.99.8.0/24"]
#   public_subnets  = "${var.public_subnets_cidr}"
#   private_subnets = "${var.private_subnets_cidr}"
#   azs             = "${local.production_availability_zones}"

#   tags = local.tags
# }

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "example" {
  vpc_id = data.aws_vpc.default.id
}

#####################################################################
################# ASG Instances Security Group for HTTP #############

# resource "aws_security_group_rule" "inbound_http" {
#   type            = "ingress"
#   from_port       = 80
#   to_port         = 80
#   protocol        = "tcp"
#   source_security_group_id = module.asg_alb_security_group.security_group_id

#   security_group_id = module.asg_instance_security_group.security_group_id
# }

# resource "aws_security_group_rule" "outbound_http" {
#   type            = "egress"
#   from_port       = 80
#   to_port         = 80
#   protocol        = "tcp"
#   source_security_group_id =  module.asg_instance_security_group.security_group_id

#   security_group_id = module.asg_alb_security_group.security_group_id
# }

#####################################################################
################# ASG Instances Security Group ######################
module "asg_instance_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "asg-instance-security-group"
  description = "Security group for instances under ASG!!!"
  # vpc_id      = module.vpc.vpc_id


  ingress_cidr_blocks = ["0.0.0.0/0"]
  # ingress_rules       = ["ssh-tcp", "all-icmp"]
  ingress_rules       = ["http-80-tcp", "ssh-tcp", "all-icmp"] // old
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

#################################################################
#################### ASG ALB Security Group #####################
module "asg_alb_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "asg-alb-security-group"
  description = "Security group for ALB under ASG!!"
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


# resource "aws_network_interface" "this" {
#   subnet_id = element(module.vpc.private_subnets, 0)
# }

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  default     = null
}

############################
## Create ALB

# resource "aws_lb" "test" {
#   name               = "greater-things"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.lb_sg.id]
#   subnets            = [for subnet in aws_subnet.public : subnet.id]

#   enable_deletion_protection = true

#   access_logs {
#     bucket  = aws_s3_bucket.lb_logs.id
#     prefix  = "test-lb"
#     enabled = true
#   }

#   tags = {
#     Environment = "production"
#   }
# }

##########################################################
######### Application Load Balancer ######################
##########################################################

module "asg_alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = "ezigbo-alb"

  load_balancer_type = "application"

  vpc_id             = data.aws_vpc.default.id
  subnets            = element([data.aws_subnet_ids.example.ids], 0)
  security_groups    = [module.asg_alb_security_group.security_group_id]


  target_groups = [
    {
      name_prefix      = "taralb"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      // added stickiness
      stickiness = {
        type = "lb_cookie" // or app_cookie
        enabled = true
        duration = 604800
      }
      targets = {
        first_target = {
          target_id = aws_instance.asg_first_instance.id
          port = 80
        }
        second_target = {
          target_id = aws_instance.asg_second_instance.id
          port = 80
        }
        third_target = {
          target_id = aws_instance.asg_third_instance.id
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
}

// Create Fixed Response Listener

resource "aws_lb_listener_rule" "health_check" {
  listener_arn = element(module.asg_alb.http_tcp_listener_arns, 0)

  action {
    type = "fixed-response"
    
    fixed_response {
      content_type = "text/plain"
      message_body = "This is an Error, I repeat!"
      status_code  = "404"
    }
  }

    condition {
      path_pattern {
        values = ["/error"]
      }
    }
}