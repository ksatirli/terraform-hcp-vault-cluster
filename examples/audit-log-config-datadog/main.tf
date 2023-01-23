module "hcp_vault" {
  source = "../.."

  cluster_id        = "audit-log-config-datadog-example"
  hvn_id            = var.hcp_hvn_id
  min_vault_version = "1.12.2"
  public_endpoint   = true
  tier              = "starter_small"

  audit_log_config = {
    enabled         = true
    datadog_api_key = var.datadog_api_key
    datadog_region  = "us1"
  }
}
