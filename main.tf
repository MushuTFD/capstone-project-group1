resource "aws_s3_bucket" "example" {

  bucket = "jl-terraform-ci-bucket"
}

# An example resource that does nothing.
resource "null_resource" "example" {
  triggers = {
    value = "A example resource that does nothing!"
  }
}