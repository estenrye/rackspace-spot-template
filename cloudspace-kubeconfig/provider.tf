terraform {
    required_version = ">= 0.13"

    backend "local" {}

    required_providers {
        local = {
          source = "hashicorp/local"
          version = "2.5.1"
        }

        spot = {
            source = "rackerlabs/spot"
            version = "0.0.8"
        }
    }
}

provider "spot" {}
