resource "github_actions_secret" "github_actions_rackspace_spot_token" {
    repository = var.github_repo
    secret_name = "RXTSPOT_TOKEN"
    plaintext_value = var.rackspace_spot_token
}