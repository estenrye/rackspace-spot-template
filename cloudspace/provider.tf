terraform {
  required_version = ">= 0.13"

  backend "s3" {
    key = "terraform.tfstate.d/cloudspace"
  }

  required_providers {
    http = {
      source  = "hashicorp/http"
      version = "3.4.3"
    }

    spot = {
      source  = "rackerlabs/spot"
      version = "0.1.0"
    }
  }
}

provider "http" {}
provider "spot" {}