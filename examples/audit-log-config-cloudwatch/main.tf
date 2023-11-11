module "hcp_vault" {
  source = "../.."

  cluster_id        = "metrics-config-cloudwatch-example"
  hvn_id            = var.hcp_hvn_id
  min_vault_version = "1.14.3"
  public_endpoint   = true
  tier              = "starter_small"

  audit_log_config = {
    enabled                      = true
    cloudwatch_access_key_id     = var.cloudwatch_access_key_id
    cloudwatch_region            = "us-east-1"
    cloudwatch_secret_access_key = var.cloudwatch_secret_access_key
  }
}
