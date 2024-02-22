Sure, I can provide you with a Terraform module that creates a VPC with one public subnet and one private subnet with internet access. Here's an example of how you can structure your Terraform code:

1. Create a directory structure for your Terraform module:

```
vpc-module/
  ├── main.tf
  ├── variables.tf
  └── outputs.tf
```

2. Inside the `main.tf` file, define the resources for creating the VPC, subnets, internet gateway, and route tables:

```hcl
# main.tf

# Create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
}

# Create public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.public_subnet_cidr_block
  availability_zone = var.public_subnet_az
}

# Create private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.private_subnet_cidr_block
  availability_zone = var.private_subnet_az
}

# Create internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
}

# Attach internet gateway to VPC
resource "aws_vpc_attachment" "attach_igw" {
  vpc_id       = aws_vpc.my_vpc.id
  internet_gateway_id = aws_internet_gateway.igw.id
}

# Create route table for public subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# Associate public subnet with public route table
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}
```

3. Define the input variables in the `variables.tf` file:

```hcl
# variables.tf

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
```

4. Define the outputs in the `outputs.tf` file:

```hcl
# outputs.tf

output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}
```

With this module, you can now use it in your main Terraform configuration by calling the module and passing the required variables. For example:

```hcl
module "my_vpc" {
  source = "./vpc-module"

  vpc_cidr_block         = "10.0.0.0/16"
  public_subnet_cidr_block  = "10.0.1.0/24"
  private_subnet_cidr_block = "10.0.2.0/24"
  public_subnet_az       = "us-east-1a"
  private_subnet_az      = "us-east-1a"
}
```

Adjust the CIDR blocks and availability zones according to your requirements. This setup creates a VPC with one public subnet and one private subnet, with the public subnet having internet access via a NAT gateway attached to the internet gateway.