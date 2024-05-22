terraform {
    required_version = ">= 0.13"

    backend "s3" {
        key = "terraform.tfstate.d/cloudspace"
    }

    required_providers {
        http = {
            source = "hashicorp/http"
            version = "3.4.2"
        }

        spot = {
            source = "rackerlabs/spot"
            version = "0.0.9"
        }
    }
}

provider "http" {}
provider "spot" {}