# vpc-module/variables.tf

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for the public subnet"
}

variable "private_subnet_cidr_block" {
  description = "CIDR block for the private subnet"
}

variable "public_subnet_az" {
  description = "Availability Zone for the public subnet"
}

variable "private_subnet_az" {
  description = "Availability Zone for the private subnet"
}

variable "attach_igw" {
  description = "Flag to determine if the internet gateway should be attached to the VPC"
  type        = bool
  default     = true
}
