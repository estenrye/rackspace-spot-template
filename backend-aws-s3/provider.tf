terraform {
  required_version = ">= 0.13"

  backend "s3" {
    key = "terraform.tfstate.d/backend-aws-s3"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.73.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "4.0.5"
    }

    github = {
      source  = "integrations/github"
      version = "6.2.2"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "github" {
  owner = var.github_orgname
  token = var.GITHUB_ADMIN_TOKEN
}