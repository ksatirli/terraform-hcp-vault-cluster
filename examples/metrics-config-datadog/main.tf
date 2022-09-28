# retrieve HVN ID of a previously created HVN
# see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/data-sources/hvn
data "hcp_hvn" "main" {
  hvn_id = "example"
}

module "hcp_vault" {
  source = "../.."

  cluster_id        = "metrics-config-datadog-example"
  hvn_id            = data.hcp_hvn.main.hvn_id
  min_vault_version = "1.10.3"
  public_endpoint   = true
  tier              = "starter_small"

  metrics_config = {
    enabled         = true
    datadog_api_key = "abc...890"
    datadog_region  = "us1"
  }
}
