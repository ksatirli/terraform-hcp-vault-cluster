module "hcp_vault" {
  source = "../.."

  cluster_id        = "simple-example"
  hvn_id            = var.hcp_hvn_id
  min_vault_version = "1.14.1"
  public_endpoint   = true
  tier              = "starter_small"
}
