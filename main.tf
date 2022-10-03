# see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster
resource "hcp_vault_cluster" "main" {
  cluster_id = var.cluster_id
  hvn_id     = var.hvn_id

  # see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster#audit_log_config
  # and https://developer.hashicorp.com/terraform/language/expressions/dynamic-blocks
  dynamic "audit_log_config" {
    # Audit Log Configuration is not allowed on `dev` tier
    for_each = (var.tier != "dev" && var.audit_log_config.enabled) ? [1] : []

    content {
      datadog_api_key    = try(var.audit_log_config.datadog_api_key, null)
      datadog_region     = try(var.audit_log_config.datadog_region, "us1")
      grafana_endpoint   = try(var.audit_log_config.grafana_endpoint, null)
      grafana_password   = try(var.audit_log_config.grafana_password, null)
      grafana_user       = try(var.audit_log_config.grafana_user, null)
      splunk_hecendpoint = try(var.audit_log_config.splunk_hecendpoint, null)
      splunk_token       = try(var.audit_log_config.splunk_token, null)
    }
  }

  # see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster#nestedblock--major_version_upgrade_config
  dynamic "major_version_upgrade_config" {
    # Major Version Upgrade configuration may only be set on clusters of STANDARD or PLUS tier
    # see https://github.com/hashicorp/terraform-provider-hcp/search?&q=only+allowed+for+STANDARD+or+PLUS+clusters
    for_each = (can(startswith("standard_", var.tier) || startswith("plus_", var.tier))) ? [1] : []

    content {
      upgrade_type            = var.major_version_upgrade_config.upgrade_type
      maintenance_window_day  = var.major_version_upgrade_config.maintenance_window_day
      maintenance_window_time = var.major_version_upgrade_config.maintenance_window_time
    }
  }

  # see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster#metrics_config
  # and https://learn.hashicorp.com/tutorials/cloud/vault-metrics-guide
  # and https://developer.hashicorp.com/terraform/language/expressions/dynamic-blocks
  dynamic "metrics_config" {
    # Metrics Configuration is not allowed on `dev` tier
    for_each = (var.tier != "dev" && var.metrics_config.enabled) ? [1] : []

    content {
      datadog_api_key    = try(var.metrics_config.datadog_api_key, null)
      datadog_region     = try(var.metrics_config.datadog_region, "us1")
      grafana_endpoint   = try(var.metrics_config.grafana_endpoint, null)
      grafana_password   = try(var.metrics_config.grafana_password, null)
      grafana_user       = try(var.metrics_config.grafana_user, null)
      splunk_hecendpoint = try(var.metrics_config.splunk_hecendpoint, null)
      splunk_token       = try(var.metrics_config.splunk_token, null)
    }
  }

  min_vault_version = var.min_vault_version

  # see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster#paths_filter
  # and https://learn.hashicorp.com/tutorials/vault/paths-filter
  paths_filter    = var.paths_filter
  primary_link    = var.primary_link
  public_endpoint = var.public_endpoint
  tier            = var.tier

  timeouts {
    create  = var.timeouts.create
    default = var.timeouts.default
    delete  = var.timeouts.delete
    update  = var.timeouts.update
  }

  lifecycle {
    # see https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle#prevent_destroy
    prevent_destroy = true
  }
}
