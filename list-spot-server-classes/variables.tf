variable cpus {
  description = "Filter for CPU"
  type        = list(string)
  default     = [">1"]
}

variable memory {
  description = "Filter for Memory"
  type        = list(string)
  default     = [">1GB"]
}

variable region {
    description = "Filter for Region"
    type        = list(string)
    default     = ["DFW", "IAD", "ORD", "HKG", "SYD"]
}

variable country {
    description = "Filter for Region Country"
    type        = list(string)
    default     = ["USA", "HKG", "AUS"]
}

variable "availability" {
  description = "Filter for Availability"
  type        = list(string)
  default     = ["available"]
}

variable "flavor" {
  description = "Filter for Flavor"
  type        = list(string)
  default     = ["virtual"]
}

variable "category" {
    description = "Filter for Category"
    type        = list(string)
    default     = ["Compute Heavy", "General Purpose", "Memory Heavy"]
}