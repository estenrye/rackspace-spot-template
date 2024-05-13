
resource "spot_cloudspace" "cloudspace" {
  cloudspace_name    = var.cloudspace_name
  region             = var.region
  hacontrol_plane    = var.hacontrol_plane
  preemption_webhook = var.preemption_webhook
}

resource "spot_spotnodepool" "node_pools" {
  for_each = var.node_pools

  cloudspace_name = var.cloudspace_name
  server_class    = each.value.server_class
  bid_price       = each.value.bid_price
  
  autoscaling = {
    min_nodes = each.value.min_nodes
    max_nodes = each.value.max_nodes
  }
}
