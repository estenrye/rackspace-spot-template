data "spot_regions" "regions" {
    filters = [
        {
            name   = "country",
            values = var.country
        },
        {
            name   = "region_provider.region_name",
            values = var.region
        }
    ]
}

data "spot_serverclasses" "classes" {
  filters = [
    {
        name = "resources.cpu"
        values = var.cpus
    },
    {
        name = "resources.memory"
        values = var.memory
    },
    {
        name = "serverclass_provider.region"
        values = data.spot_regions.regions.names
    },
    {
        name = "availability"
        values = var.availability
    },
    {
        name = "flavor_type"
        values = var.flavor
    },
    {
        name = "category"
        values = var.category
    }
  ]
}

output "server_classes" {
  value = data.spot_serverclasses.classes.names
}
