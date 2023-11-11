module "hcp_vault" {
  source = "../.."

  cluster_id        = "simple-example"
  hvn_id            = module.hvn_azure.hcp_hvn.hvn_id
  min_vault_version = "1.14.3"
  public_endpoint   = true
  tier              = "dev"
}
