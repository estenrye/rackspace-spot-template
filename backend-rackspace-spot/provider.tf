terraform {
  required_version = ">= 0.13"

  backend "local" {}

  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.13.0"
    }
  }
}

provider "github" {
  owner = var.github_orgname
}