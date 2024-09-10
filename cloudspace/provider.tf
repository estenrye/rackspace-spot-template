terraform {
  required_version = ">= 0.13"

  backend "s3" {
    key = "terraform.tfstate.d/cloudspace"
  }

  required_providers {
    http = {
      source  = "hashicorp/http"
      version = "3.4.5"
    }

    spot = {
      source  = "rackerlabs/spot"
      version = "0.0.11"
    }
  }
}

provider "http" {}
provider "spot" {}