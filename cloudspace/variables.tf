variable "cloudspace_name" {
  description = "Name of the Rackspace Spot Cloudspace"
  type        = string
  default     = "example"
}

variable "region" {
  description = "Region of the Rackspace Spot Cloudspace"
  type        = string
  default     = "DFW"
}

variable "ha_control_plane" {
  description = "High availability control plane"
  type        = bool
  default     = false
}

variable "preemption_webhook" {
  description = "URL of the preemption webhook"
  type        = string
  nullable    = true
  default     = null
}
