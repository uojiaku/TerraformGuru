provider "aws" {
  region = local.region
}

locals {
  name   = "oganiru"
  region = "us-east-1"

  # user_data = <<EOT
  # #!/bin/bash
  # # Use this for your user data (script from top to bottom)
  # # install httpd (Linux 2 version)
  # yum update -y
  # yum install -y httpd
  # systemctl start httpd
  # systemctl enable httpd
  # echo "<h1>Hello world from $(hostname -f) </h1>" > /var/www/html/index.html
  # EOT

  user_data = <<EOT
  #!/bin/bash
  yum update -y
  yum install -y httpd
  systemctl start httpd
  systemctl enable httpd
  EC2_AVAIL_ZONE=$(curl -s https://169.254.169.254/latest/meta-data/placement/availability-zone)
  echo "<h1>Hello World from $(hostname -f) in AZ $EC2_AVAIL_ZONE </h1> > /var/www/html/index/html
  EOT

  tags = {
    Owner       = "ec2-user"
    Environment = "dev"
  }
  production_availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

}

################################################################################
# EC2 Module
################################################################################

# module "ec2_instance" {
#   source = "terraform-aws-modules/ec2-instance/aws"
#   version = "~> 3.0"
#   name = "${local.name}-metadata-options"

#   vpc_security_group_ids = [module.security_group.security_group_id]
#   availability_zone      = var.availability_zone
#   # subnet_id         = element(module.vpc.private_subnets, 0)

#   subnet_id              = var.subnet_id
#   # vpc_security_group_ids = var.vpc_security_group_ids

#   user_data                     = file("./user-data.sh")
#   # user_data_base64            = var.user_data_base64
#   # user_data_replace_on_change = var.user_data_replace_on_change

#   metadata_options = {
#     http_endpoint               = "enabled"
#     http_tokens                 = "required"
#     http_put_response_hop_limit = 8
#     instance_metadata_tags      = "enabled"
#   }

#   tags = local.tags
# }



################################################################################
# EC2 Module - multiple instances with `for_each`
################################################################################

# locals {
#   multiple_instances = {
#     one = {
#       instance_type     = "t2.micro"
#       # availability_zone = element(module.vpc.azs, 0)
#       # subnet_id         = element(module.vpc.private_subnets, 0)
#       availability_zone      = var.availability_zone
#       subnet_id              = var.subnet_id
#       root_block_device = [
#         {
#           encrypted   = true
#           volume_type = "gp3"
#           throughput  = 200
#           volume_size = 50
#           tags = {
#             Name = "my-root-block"
#           }
#         }
#       ]
#     }
#     two = {
#       instance_type     = "t2.micro"
#       # availability_zone = element(module.vpc.azs, 1)
#       # subnet_id         = element(module.vpc.private_subnets, 1)
#       availability_zone      = var.availability_zone
#       subnet_id              = var.subnet_id
#       root_block_device = [
#         {
#           encrypted   = true
#           volume_type = "gp2"
#           volume_size = 50
#         }
#       ]
#     }
#     three = {
#       instance_type     = "t2.micro"
#       # availability_zone = element(module.vpc.azs, 2)
#       # subnet_id         = element(module.vpc.private_subnets, 2)
#       availability_zone      = var.availability_zone
#       subnet_id              = var.subnet_id
#       root_block_device = [
#         {
#           encrypted   = true
#           volume_type = "gp2"
#           volume_size = 50
#         }
#       ]
#     }
#   }
# }

# module "ec2_instance" {
#   source = "terraform-aws-modules/ec2-instance/aws"
#   version = "~> 3.0"
#   for_each = local.multiple_instances

#   name = "${local.name}-multi-${each.key}"
#   # ami                    = data.aws_ami.amazon_linux.id
#   ami                    = data.aws_ami.amazon-linux-2.id
#   instance_type          = each.value.instance_type
#   availability_zone      = each.value.availability_zone
#   subnet_id              = each.value.subnet_id
#   vpc_security_group_ids = [module.security_group.security_group_id]
#   key_name               = "tf-key-pair"

#   # user_data                   = var.user_data
#   user_data_base64            = base64encode(var.user_data)

#   enable_volume_tags = false
#   root_block_device  = lookup(each.value, "root_block_device", [])

#   tags = local.tags
# }

################################################################################
############################ EC2 Instances #####################################
################################################################################

resource "aws_instance" "first_instance" {
  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = var.instance_type
  availability_zone      = element(local.production_availability_zones, 0)
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [module.instance_security_group_1.security_group_id]
  key_name               = "tf-key-pair"

  user_data_base64            = base64encode(var.user_data)

  root_block_device {
          encrypted   = true
          volume_type = "gp2"
          volume_size = 50
        }
      
  tags = { Name = "Eligwe_1"}

 }

########################## EC2 instance 2 #####################################

resource "aws_instance" "second_instance" {
  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = var.instance_type
  availability_zone      = element(local.production_availability_zones, 1) 
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [module.instance_security_group.security_group_id]
  key_name               = "tf-key-pair"

  user_data_base64            = base64encode(var.user_data)

  root_block_device {
          encrypted   = true
          volume_type = "gp2"
          volume_size = 50
        }
      
  tags = { Name = "Eligwe_2"} 
}

########################## EC2 instance 3 #####################################

resource "aws_instance" "third_instance" {
  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = var.instance_type
  availability_zone      = element(local.production_availability_zones, 2) 
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [module.instance_security_group.security_group_id]
  key_name               = "tf-key-pair"

  user_data_base64            = base64encode(var.user_data)

  root_block_device  {
          encrypted   = true
          volume_type = "gp2"
          volume_size = 50
        }

   tags = { Name = "Eligwe_3"} 

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

# data "aws_subnets" "example" {
#   filter {
#     name = "subnet"
#     values = [data.aws_vpc.default.subnets]
#  }
# }
data "aws_subnet_ids" "example" {
  vpc_id = data.aws_vpc.default.id
}


data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }
}

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

# RHEL 8.5
data "aws_ami" "rhel_8_5" {
  most_recent = true
  owners = ["309956199498"] // Red Hat's Account ID
  filter {
    name   = "name"
    values = ["RHEL-8.5*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

#################################################################
################# Instances Security Group for HTTP #############

resource "aws_security_group_rule" "inbound_http" {
  type            = "ingress"
  from_port       = 80
  to_port         = 80
  protocol        = "tcp"
  source_security_group_id = module.alb_security_group.security_group_id

  security_group_id = module.instance_security_group.security_group_id
}

resource "aws_security_group_rule" "outbound_http" {
  type            = "egress"
  from_port       = 80
  to_port         = 80
  protocol        = "tcp"
  source_security_group_id =  module.instance_security_group.security_group_id

  security_group_id = module.alb_security_group.security_group_id
}

#################################################################
######### Instances Security Group (instance 1) #################
module "instance_security_group_1" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "instance-security-group-1"
  description = "Security group for instances!!!"
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
################# Instances Security Group ######################
module "instance_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "instance-security-group"
  description = "Security group for instances!!!"
  # vpc_id      = module.vpc.vpc_id


  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp", "all-icmp"]
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

#############################################################
#################### ALB Security Group #####################
module "alb_security_group_1" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "alb-security-group-1"
  description = "Security group for ALB!!"
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

resource "aws_placement_group" "web" {
  name     = local.name
  strategy = "cluster"
}

## create key pair 
resource "aws_key_pair" "tf-key-pair" {
    key_name = "tf-key-pair"
    public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "local_file" "tf-key" {
    content = tls_private_key.rsa.private_key_pem
    filename = "tf-key-pair"
}

resource "aws_kms_key" "this" {
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

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = "eligwe-alb"

  load_balancer_type = "application"

  vpc_id             = data.aws_vpc.default.id
  subnets            = element([data.aws_subnet_ids.example.ids], 0)
  security_groups    = [module.alb_security_group.security_group_1_id]


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
          target_id = aws_instance.first_instance.id
          port = 80
        }
        second_target = {
          target_id = aws_instance.second_instance.id
          port = 80
        }
        third_target = {
          target_id = aws_instance.third_instance.id
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

// ALB SSL Listener

# https_listeners = [
#     {
#       port               = 443
#       protocol           = "HTTPS"
#       certificate_arn    = module.acm.acm_certificate_arn
#       target_group_index = 1
#     },
#   ]


#   tags = {
#     Environment = "Test"
#   }
# }
}
// Create Fixed Response Listener

resource "aws_lb_listener_rule" "health_check" {
  listener_arn = element(module.alb.http_tcp_listener_arns, 0)

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

// Create ACM for Certificate

# module "acm" {
#   source  = "terraform-aws-modules/acm/aws"
#   version = "~> 4.0"

#   domain_name  = "my-domain.com"
#   zone_id      = "Z2ES7B9AZ6SHAE"

#   subject_alternative_names = [
#     "*.my-domain.com",
#     "app.sub.my-domain.com",
#   ]

#   wait_for_validation = true

#   tags = {
#     Name = "my-domain.com"
#   }
# }

  # condition {
  #   query_string {
  #     key   = "health"
  #     value = "check"
  #   }

  #   query_string {
  #     value = "bar"
  #   }
  # }
}


// Create Instance Target group


# # # creates target group
# resource "aws_lb_target_group" "test" {
#   name     = "eligwe-targetgroup"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   =  data.aws_vpc.default.id
# }

# # attaches instances to target group
# resource "aws_lb_target_group_attachment" "first_instance" {
#   target_group_arn = aws_lb_target_group.test.arn
#   target_id        = aws_instance.first_instance.id
#   port             = 80
# }

# # attaches instances to target group
# resource "aws_lb_target_group_attachment" "second_instance" {
#   target_group_arn = aws_lb_target_group.test.arn
#   target_id        = aws_instance.second_instance.id
#   port             = 80
# }

# # attaches instances to target group
# resource "aws_lb_target_group_attachment" "third_instance" {
#   target_group_arn = aws_lb_target_group.test.arn
#   target_id        = aws_instance.third_instance.id
#   port             = 80
# }


