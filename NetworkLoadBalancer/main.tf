provider "aws" {
  region = local.region
}

locals {
  name   = "onuogugu"
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

################################################################################
############################ EC2 Instances #####################################
################################################################################

resource "aws_instance" "first_instance_2" {
  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = var.instance_type
  availability_zone      = element(local.production_availability_zones, 0)
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [module.instance_security_group_2.security_group_id]
  key_name               = "tf-key-pair-2"

  user_data_base64            = base64encode(var.user_data)

  root_block_device {
          encrypted   = true
          volume_type = "gp2"
          volume_size = 50
        }
      
  tags = { Name = "Mgbidi_1"}

 }

########################## EC2 instance 2 #####################################

resource "aws_instance" "second_instance_2" {
  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = var.instance_type
  availability_zone      = element(local.production_availability_zones, 1) 
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [module.instance_security_group_2.security_group_id]
  key_name               = "tf-key-pair-2"

  user_data_base64            = base64encode(var.user_data)

  root_block_device {
          encrypted   = true
          volume_type = "gp2"
          volume_size = 50
        }
      
  tags = { Name = "Mgbidi_2"} 
}

########################## EC2 instance 3 #####################################

resource "aws_instance" "third_instance_2" {
  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = var.instance_type
  availability_zone      = element(local.production_availability_zones, 2) 
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [module.instance_security_group_2.security_group_id]
  key_name               = "tf-key-pair-2"

  user_data_base64            = base64encode(var.user_data)

  root_block_device  {
          encrypted   = true
          volume_type = "gp2"
          volume_size = 50
        }

   tags = { Name = "Mgbidi_3"} 

}
################################################################################
# Supporting Resources
################################################################################

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "example" {
  vpc_id = data.aws_vpc.default.id
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


#################################################################
################# Instances Security Group ######################
module "instance_security_group_2" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "instance-security-group-2"
  description = "Security group for instances!!!"
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
#################### NLB Security Group #####################
module "nlb_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "nlb-security-group"
  description = "Security group for NLB!!"
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
    key_name = "tf-key-pair-2"
    public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "local_file" "tf-key" {
    content = tls_private_key.rsa.private_key_pem
    filename = "tf-key-pair-2"
}

resource "aws_kms_key" "this" {
}


variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  default     = null
}



##########################################################
######### Network Load Balancer ######################
##########################################################

module "nlb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = "eligwe-NLB"

  load_balancer_type = "network"

  vpc_id             = data.aws_vpc.default.id
  subnets            = element([data.aws_subnet_ids.example.ids], 0)
  // enabled cross zone load balancing
  enable_cross_zone_load_balancing = true


  target_groups = [
    {
      name_prefix       = "tarNLB"
      backend_protocol  = "TCP"
      backend_port      = 80
      target_type       = "instance"
      health_check = {
        enabled           = true
        healthy_threshold = 2
        interval          = 5
        timeout           = 2
        path              = "/"
    }
      targets = {
        first_target = {
          target_id = aws_instance.first_instance_2.id
          port = 80
        }
        second_target = {
          target_id = aws_instance.second_instance_2.id
          port = 80
        }
        third_target = {
          target_id = aws_instance.third_instance_2.id
          port = 80
        }
      }
    }
  ]


  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "TCP"
      target_group_index = 0
    }
  ]


  tags = {
    Environment = "Test"
  }
}


