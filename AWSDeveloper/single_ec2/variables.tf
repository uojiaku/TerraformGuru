variable "instance_type" {
  description = "gpu instance"
  default   = "g4dn.xlarge"
}

variable "subnets" {
  description = "The list for subnet"
  type        = list
  default     = null
}

variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  type        = string
  default     = null
}
