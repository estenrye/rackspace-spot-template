terraform {
    required_version = ">= 0.13"

    backend "local" {}

    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "5.52.0"
        }

        github = {
            source = "integrations/github"
            version = "6.2.1"
        }
    }
}

provider "aws" {
    region = var.aws_region
}

provider "github" {
    owner = var.github_orgname
}