variable "aws_region" {
  default = "us-east-2"
  type    = string
}

variable "backend_name" {
  default = "tf-state-backend"
  type    = string
}

variable "bucket_name" {
  default = "tf-cloudspace-bucket"
  type    = string
}

variable "force_destroy" {
  default = false
  type    = bool
}

variable "bucket_paths" {
  default = [
    "terraform.tfstate/cloudspace",
    "terraform.tfstate/cloudspace-health",
    "terraform.tfstate/cloudspace-kubeconfig",
  ]
  type    = list(string)
}

variable "github_orgname" {
  type = string
  default = "estenrye"
}

variable "github_repo" {
  type = string
  default = "rackspace-spot-template"
}
