data "spot_kubeconfig" "cloudspace_config" {
  cloudspace_name = var.cloudspace_name
}

resource "local_sensitive_file" "home_kubeconfig" {
  content  = data.spot_kubeconfig.cloudspace_config.raw
  filename = pathexpand("~/.kube/${var.cloudspace_name}-kubeconfig.yaml")
}
