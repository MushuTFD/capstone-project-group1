terraform {
  required_version = ">= 1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.31.0"
    }
  }

  cloud {
    organization = "jinnliong_org" #Update to your organization name

    workspaces {
      name = "ec2-dev"
    }
  }
}