terraform {
  required_version = ">= 0.13"

  backend "local" {}

  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.2.2"
    }
  }
}

provider "github" {
  owner = var.github_orgname
}