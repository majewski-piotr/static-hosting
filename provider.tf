terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  profile = var.aws_profile

  default_tags {
    tags = {
      created_by = "Terraform"
      project    = "static_hosting"
      id         = var.name
    }
  }
}

provider "aws" {
  alias   = "us-east"
  region  = "us-east-1"
  profile = var.aws_profile

  default_tags {
    tags = {
      created_by = "Terraform"
      project    = "static_hosting"
      id         = var.name
    }
  }
}
