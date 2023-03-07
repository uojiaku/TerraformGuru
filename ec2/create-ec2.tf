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

## create ec2 instance

resource "aws_instance" "myserv" {
    ami = "ami-006dcf34c09e50022"
    instance_type = "t2.micro"
    # subnet_id = lookup(var.awsprops, "subnet")
    # availability_zone = "us-east-1a"
    key_name = aws_key_pair.tf-key-pair.key_name
    root_block_device {
    delete_on_termination = true
    volume_size = 50
    volume_type = "gp2"
    }
    tags = {
        Name = "Genesis"
    }
    network_interface {
      device_index = 0
      network_interface_id = lookup(var.awsprops, "interface_id")
}
  }

## output info from ec2 instance
output "server_private_ip" {
    value = aws_instance.myserv.private_ip
}

output "server_public_ipv4" {
    value = aws_instance.myserv.public_ip
}

output "server_id" {
    value = aws_instance.myserv.id
}

## create security group
resource "aws_security_group" "project-iac-sg" {
  name = lookup(var.awsprops, "secgroupname")
  description = lookup(var.awsprops, "secgroupdescription")
  vpc_id = lookup(var.awsprops, "vpc")

  ## To Allow SSH Transport
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ## To Allow Port 80 Transport
  ingress {
    from_port = 80
    protocol = "http"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

# locals {
#     is_security_group_existing = "${(data.aws_security_group.project-iac-sg.name)}"
# }

# ## output data
# output "output_data" {
#     value = data.aws_security_group.project-iac-sg.name
# }