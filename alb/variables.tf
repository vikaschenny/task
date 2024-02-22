variable "region" {
  description = "AWS region"
}

variable "alb_name" {
  description = "Name for the ALB"
}

variable "internal" {
  description = "Whether the ALB is internal"
  default     = false
}

variable "load_balancer_type" {
  description = "Type of load balancer"
  default     = "application"
}

variable "security_group_id" {
  description = "ID of the security group"
}

variable "subnets" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "port" {
  description = "Port for the target group"
  default     = 80
}

variable "protocol" {
  description = "Protocol for the target group"
  default     = "HTTP"
}

variable "vpc_id" {
  description = "ID of the VPC"
}

variable "target_type" {
  description = "Type of targets"
  default     = "instance"
}

variable "blue_target_group_name" {
  description = "Name for the blue target group"
}

variable "green_target_group_name" {
  description = "Name for the green target group"
}

variable "blue_target_id" {
  description = "ID for the blue target"
}

variable "green_target_id" {
  description = "ID for the green target"
}

variable "listener_port" {
  description = "Port for the listener"
}

variable "target_group_id" {
  description = "ID of the target group to attach to the ALB"
}
