locals {
  json_files = fileset(path.module, "vars/${var.cloudspace_name}/nodepools/*.json")
  json_data  = [for f in local.json_files : jsondecode(file("${path.module}/${f}"))]
  node_pools = {
    for obj in local.json_data : "${obj.name}" => {
        cpus     = [ "${obj.cpus}" ]
        memory   = [ "${obj.memory}" ]
        category = [ "${obj.category}" ]
        min_nodes = tonumber(obj.min_nodes)
        max_nodes = tonumber(obj.max_nodes)
        max_bid   = tonumber(obj.max_bid)
    }
  }
}

data "spot_regions" "spot_region" {
    filters = [
        {
            name   = "region_provider.region_name",
            values = [ var.region ]
        }
    ]
}

data "spot_serverclasses" "nodepool_serverclasses" {
    for_each = local.node_pools

    filters = [
        {
            name = "resources.cpu"
            values = each.value.cpus
        },
        {
            name = "resources.memory"
            values = each.value.memory
        },
        {
            name = "serverclass_provider.region"
            values = data.spot_regions.spot_region.names
        },
        {
            name = "availability"
            values = [ "available" ]
        },
        {
            name = "category"
            values = each.value.category
        }
    ]
}


data "http" "bid_price_percentiles" {
    url = "https://ngpc-prod-public-data.s3.us-east-2.amazonaws.com/percentiles.json"
}

locals {
    region_name = data.spot_regions.spot_region.names[0]
    bid_info = jsondecode(data.http.bid_price_percentiles.response_body)
}

resource "spot_cloudspace" "cloudspace" {
  cloudspace_name    = var.cloudspace_name
  region             = local.region_name
  hacontrol_plane    = var.ha_control_plane
  preemption_webhook = var.preemption_webhook
}

data "spot_serverclass" "nodepool_serverclasses" {
    for_each = local.node_pools

    name = data.spot_serverclasses.nodepool_serverclasses[each.key].names[0]
}

resource "spot_spotnodepool" "nodepool" {
  for_each = local.node_pools

  cloudspace_name = var.cloudspace_name
  server_class    = data.spot_serverclass.nodepool_serverclasses[each.key].name
  bid_price       = max(
    tonumber(data.spot_serverclass.nodepool_serverclasses[each.key].status.spot_pricing.hammer_price_per_hour),
    local.bid_info.regions[local.region_name][data.spot_serverclass.nodepool_serverclasses[each.key].name]["80_percentile"],
    each.value.max_bid
  )
  
  autoscaling = {
    min_nodes = each.value.min_nodes
    max_nodes = each.value.max_nodes
  }
}