provider "aws" {
  region = "us-east-1"
}

module "alb" {
  source = "./alb"

  region              = "us-east-1"
  alb_name            = "node-app2-alb"
  internal            = false
  load_balancer_type  = "application"
  security_group_id   = "sg-038da15b190064d84"
  subnets             = ["subnet-0990ccabcef02c8ab", "subnet-0990ccabcef02c8ab"]
  vpc_id              = "vpc-05e2849a3739f1d21"
  blue_target_group_name = "blue-target-group"
  green_target_group_name = "green-target-group"
  blue_target_id      = "i-058bd8737d088ae70"
  green_target_id     = "i-01fc31c7558592d7d"
  listener_port       = 80
  target_group_id     = "blue"  # or "green" based on your requirement
}
