variable "cloudspace_name" {
    description = "Name of the Rackspace Spot Cloudspace"
    type        = string
    default     = "example"
}

variable "region" {
    description = "Region of the Rackspace Spot Cloudspace"
    type        = string
    default     = "us-central-dfw-1"
}

variable "node_pools" {
    description = "List of Rackspace Spot Node Pools"
    type        = map(object({
        server_class = string
        bid_price = number
        min_nodes = number
        max_nodes = number
    }))
    default     = {}
}

variable "hacontrol_plane" {
    description = "High availability control plane"
    type        = bool
    default     = false
}

variable "preemption_webhook" {
    description = "URL of the preemption webhook"
    type        = string
    default     = null
}