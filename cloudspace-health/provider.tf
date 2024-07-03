terraform {
  required_version = ">= 0.13"

  backend "s3" {
    key = "terraform.tfstate.d/cloudspace-health"
  }

  required_providers {
    spot = {
      source  = "rackerlabs/spot"
      version = "0.0.10"
    }
  }
}

provider "spot" {}
