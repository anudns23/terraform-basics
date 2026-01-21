terraform {
  backend "s3" {
    bucket = "demo-basic-bucket-21-01-2026"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}



