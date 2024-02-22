# ec2-module/outputs.tf

output "public_instance_ids" {
  value = aws_instance.public_instance[*].id
}

output "private_instance_ids" {
  value = aws_instance.private_instance[*].id
}
