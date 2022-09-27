# retrieve HVN ID of a previously created HVN
# see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/data-sources/hvn
data "hcp_hvn" "main" {
  hvn_id = "workloads-aws-us-west-2"
}

module "hcp_vault" {
  source = "../.."

  cluster_id        = "simple"
  hvn_id            = data.hcp_hvn.main.hvn_id
  min_vault_version = "1.10.1"
  public_endpoint   = true
  tier              = "dev"

  metrics_config = {
    enabled            = true
    datadog_api_key    = "5b7bc5ad87453e010d6dade19c14aeb5"
    datadog_region     = "us1"
  }
}
