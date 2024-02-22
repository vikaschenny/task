provider "aws" {
  region = var.region
}

resource "aws_lb" "example" {
  name               = var.alb_name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = [var.security_group_id]
  subnets            = var.subnets
  
  tags = {
    Name = var.alb_name
  }
}

resource "aws_lb_target_group" "blue" {
  name        = var.blue_target_group_name
  port        = var.port
  protocol    = var.protocol
  vpc_id      = var.vpc_id
  target_type = var.target_type
}

resource "aws_lb_target_group" "green" {
  name        = var.green_target_group_name
  port        = var.port
  protocol    = var.protocol
  vpc_id      = var.vpc_id
  target_type = var.target_type
}

resource "aws_lb_target_group_attachment" "blue_attachment" {
  target_group_arn = aws_lb_target_group.blue.arn
  target_id        = var.blue_target_id
  port             = var.port
}

resource "aws_lb_target_group_attachment" "green_attachment" {
  target_group_arn = aws_lb_target_group.green.arn
  target_id        = var.green_target_id
  port             = var.port
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.example.arn
  port              = var.listener_port
  protocol          = var.protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group[var.target_group_id].arn
  }
}
