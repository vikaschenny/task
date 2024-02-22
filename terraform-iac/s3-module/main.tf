# modules/s3/main.tf

# Create S3 bucket for storing Terraform state file
resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = var.bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }
}


