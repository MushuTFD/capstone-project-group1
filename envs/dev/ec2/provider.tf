provider "aws" {
  # The region is automatically determined from the AWS_DEFAULT_REGION environment variable
  region = var.aws_region
}