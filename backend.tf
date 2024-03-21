terraform {
  backend "s3" {
    bucket = "sctp-ce4-tfstate-bucket-group1"
    key    = "sctp-ce4-project-g1"
    region = "ap-southeast-1"
  }
}