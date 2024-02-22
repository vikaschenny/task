provider "aws" {
  region = "us-east-1" # Change to your desired region
}

module "s3_state_bucket" {
  source = "./s3-module"

  bucket_name = "toptal-arjun-terraform-state-bucket"
}

terraform {
  backend "s3" {
    bucket         = "toptal-arjun-terraform-state-bucket"
    key            = "terraform.tfstate"
    region         = "us-east-1" # Change to the region where your S3 bucket is located
    encrypt        = true
    dynamodb_table = "terraform_locks" # Optional: Use DynamoDB for state locking
  }
}

module "my_vpc" {
  source = "./vpc-module"

  vpc_cidr_block         = "10.0.0.0/16"
  public_subnet_cidr_block  = "10.0.1.0/24"
  private_subnet_cidr_block = "10.0.2.0/24"
  public_subnet_az       = "us-east-1a"
  private_subnet_az      = "us-east-1a"
  attach_igw             = false
}

module "my_ec2" {
  source = "./ec2-module"

  create_public_instance  = true
  create_private_instance = true
  public_ami             = "ami-0c7217cdde317cfec" # Change to your public AMI ID
  private_ami            = "ami-0c7217cdde317cfec" # Change to your private AMI ID
  public_instance_type    = "t2.micro"
  private_instance_type   = "t2.micro"
  public_key              = file("~/.ssh/id_rsa.pub")
  private_key             =    file("~/.ssh/id_rsa")
  vpc_id = module.my_vpc.vpc_id
  public_subnet_id = module.my_vpc.public_subnet_id
  private_subnet_id = module.my_vpc.private_subnet_id
}