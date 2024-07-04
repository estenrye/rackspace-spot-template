variable "aws_region" {
  default = "us-east-2"
  type    = string
}

variable "bucket_name" {
  default = "tf-cloudspace-bucket"
  type    = string
}

variable "logging_bucket_name" {
  default = "ryezone-labs-s3-access-logs"
  type    = string
}

variable "force_destroy" {
  default = false
  type    = bool
}

variable "github_orgname" {
  type    = string
  default = "estenrye"
}

variable "github_repo" {
  type    = string
  default = "rackspace-spot-template"
}
