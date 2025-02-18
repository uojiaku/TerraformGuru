provider "aws" {
  region = local.region
}

locals {
  name   = "ruo"
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
# EC2 Module - multiple instances with `for_each`
################################################################################

locals {
  multiple_instances = {
    one = {
      instance_type     = "t2.micro"
      # availability_zone = element(module.vpc.azs, 0)
      # subnet_id         = element(module.vpc.private_subnets, 0)
      availability_zone      = element(local.production_availability_zones, 0)
      subnet_id              = var.subnet_id
      root_block_device = [
        {
          encrypted   = true
          volume_type = "gp3"
          throughput  = 200  // not for gp2
          volume_size = 50
          tags = {
            Name = "my-root-block"
          }
        }
      ]
    }
    two = {
      instance_type     = "t2.micro"
      # availability_zone = element(module.vpc.azs, 1)
      # subnet_id         = element(module.vpc.private_subnets, 1)
      availability_zone      = element(local.production_availability_zones, 1) 
      subnet_id              = var.subnet_id
      root_block_device = [
        {
          encrypted   = true
          volume_type = "gp2"
          volume_size = 50
          tags = {
            Name = "my-root-block"
          }
        }
      ]
    }
    three = {
      instance_type     = "t2.micro"
      # availability_zone = element(module.vpc.azs, 2)
      # subnet_id         = element(module.vpc.private_subnets, 2)
      availability_zone      = element(local.production_availability_zones, 2) 
      subnet_id              = var.subnet_id
      root_block_device = [
        {
          encrypted   = true
          volume_type = "gp2"
          volume_size = 50
          tags = {
            Name = "my-root-block"
          }
        }
      ]
    }
  }
}

module "create_ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"
  for_each = local.multiple_instances

  name = "${local.name}-${each.key}"
  # ami                    = data.aws_ami.amazon_linux.id
  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = each.value.instance_type
  availability_zone      = each.value.availability_zone
  subnet_id              = each.value.subnet_id
  vpc_security_group_ids = [module.instance_security_group.security_group_id]
  key_name               = "tf-key-pair-3"

  # user_data                   = var.user_data
  user_data_base64            = base64encode(var.user_data)

  enable_volume_tags = false
  root_block_device  = lookup(each.value, "root_block_device", [])

  tags = local.tags
}


################################################################################
# Supporting Resources
################################################################################

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
################# Instances Security Group ######################
module "instance_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "instance-security-group"
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

############# More Supporting Resources ######################

resource "aws_placement_group" "web" {
  name     = local.name
  strategy = "cluster"
}

## create key pair 
resource "aws_key_pair" "tf-key-pair_3" {
    key_name = "tf-key-pair-3"
    public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "local_file" "tf-key" {
    content = tls_private_key.rsa.private_key_pem
    filename = "tf-key-pair-3"
}

resource "aws_kms_key" "this" {
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  default     = null
}






