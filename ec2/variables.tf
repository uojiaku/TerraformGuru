variable "user_data" {
  description = "The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead."
  type        = string
  default     = <<-EOT
#!/bin/bash
# Use this for your user data (script from top to bottom)
# install httpd (Linux 2 version)
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>Hello world from $(hostname -f) </h1>" > /var/www/html/index.html
EOT
}


variable "user_data_base64" {
  description = "Can be used instead of user_data to pass base64-encoded binary data directly. Use this instead of user_data whenever the value is not a valid UTF-8 string. For example, gzip-encoded user data must be base64-encoded and passed via this argument to avoid corruption."
  type        = string
  default     = null
}

variable "user_data_replace_on_change" {
  description = "When used in combination with user_data or user_data_base64 will trigger a destroy and recreate when set to true. Defaults to false if not set."
  type        = bool
  default     = false
}


variable "availability_zone" {
  description = "AZ to start the instance in"
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  type        = string
  default     = null
}


variable "region" {
  description = "us-east-1"
    default     = "us-east-1"

}

variable "environment" {
  description = "The Deployment environment"
    default     = null

}

//Networking
variable "vpc_cidr" {
  description = "The CIDR block of the vpc"
    default     = null

}

variable "public_subnets_cidr" {
  type        = list
  description = "The CIDR block for the public subnet"
    default     = []

}

variable "private_subnets_cidr" {
  type        = list
  description = "The CIDR block for the private subnet"
    default     = []
}

variable "instance_type" {
  description = "instance type of t2 micro"
  default   = "t2.micro"
}

variable "subnets" {
  description = "The list for subnet"
  type        = list
  default     = null
}
