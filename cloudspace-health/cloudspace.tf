data "spot_cloudspace" "example" {
  name = var.cloudspace_name
}

# This outputs the current phase of the cloudspace.
output "csphase" {
  value = data.spot_cloudspace.example.phase
}

output "cshealth" {
  value = data.spot_cloudspace.example.health
}

output "csreason" {
  value = data.spot_cloudspace.example.reason
}