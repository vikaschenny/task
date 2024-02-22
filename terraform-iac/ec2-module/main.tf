resource "aws_instance" "public_instance" {
  count         = var.create_public_instance ? 2 : 0
  ami           = var.public_ami
  instance_type = var.public_instance_type
  subnet_id     = var.public_subnet_id
  key_name      = aws_key_pair.ec2_key.key_name
  associate_public_ip_address = true
   user_data = <<-EOF
     #!/bin/bash
         
         # Check if Docker is installed
         if ! command -v docker &> /dev/null; then
             echo "Docker is not installed. Installing Docker..."
             # Install Docker
             curl -fsSL https://get.docker.com -o get-docker.sh
             sudo sh get-docker.sh
             # Add current user to docker group to run Docker commands without sudo
             sudo usermod -aG docker $(whoami)
             echo "Docker installed successfully."
         fi
         
    EOF
  
  vpc_security_group_ids = var.create_public_instance ? [aws_security_group.public_sg.id] : []

  tags = {
    Name = "PublicInstance"
  }
}



resource "aws_instance" "private_instance" {
  count         = var.create_private_instance ? 1 : 0
  ami           = var.private_ami
  instance_type = var.private_instance_type
  subnet_id     = var.private_subnet_id
  key_name      = aws_key_pair.ec2_key.key_name
  user_data     = <<-EOF
     #!/bin/bash
         
         # Check if Docker is installed
         if ! command -v docker &> /dev/null; then
             echo "Docker is not installed. Installing Docker..."
             # Install Docker
             curl -fsSL https://get.docker.com -o get-docker.sh
             sudo sh get-docker.sh
             # Add current user to docker group to run Docker commands without sudo
             sudo usermod -aG docker $(whoami)
             echo "Docker installed successfully."
         fi
         
         # Pull MySQL Docker image
         echo "Pulling MySQL Docker image..."
         docker pull mysql:latest
         
         # Run MySQL container
         echo "Running MySQL container..."
         docker run -d -p 3306:3306 --name mysql-container -e MYSQL_DATABASE=demo -e MYSQL_ROOT_PASSWORD=password mysql:latest
         
         echo "MySQL container is up and running."
         
    EOF
  security_groups = [aws_security_group.private_sg.id]

  tags = {
    Name = "PrivateInstance"
  }
}

resource "aws_key_pair" "ec2_key" {
  key_name   = "ec2_key"
  public_key = var.public_key
}

resource "aws_security_group" "public_sg" {
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "private_sg" {
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
}
