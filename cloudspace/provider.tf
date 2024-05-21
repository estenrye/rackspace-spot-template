terraform {
    required_version = ">= 0.13"

    backend "s3" {
        key = "terraform.tfstate.d/cloudspace"
    }

    required_providers {
        spot = {
            source = "rackerlabs/spot"
            version = "0.0.8"
        }
    }
}

provider "spot" {}
