variable "create_public_instance" {
  description = "Set to true to create a public instance"
  type        = bool
  default     = true
}

variable "create_private_instance" {
  description = "Set to true to create a private instance"
  type        = bool
  default     = true
}

variable "public_ami" {
  description = "AMI for public instance"
}

variable "private_ami" {
  description = "AMI for private instance"
}

variable "public_instance_type" {
  description = "Instance type for public instance"
}

variable "private_instance_type" {
  description = "Instance type for private instance"
}

variable "public_key" {
  description = "SSH public key"
}
variable "vpc_id" {
  description = "ID of the VPC"
}

variable "public_subnet_id" {
  description = "ID of the public subnet"
}

variable "private_subnet_id" {
  description = "ID of the private subnet"
}
variable "private_key" {
    description = "SSH public key"
}