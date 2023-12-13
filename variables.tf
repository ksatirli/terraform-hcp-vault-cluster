variable "cluster_id" {
  type        = string
  description = "The ID of the HCP Vault cluster."
}

variable "hvn_id" {
  type        = string
  description = "The ID of the HVN this HCP Vault cluster is associated to."
}

variable "audit_log_config" {
  type = object({
    enabled                      = bool
    cloudwatch_access_key_id     = optional(string)
    cloudwatch_region            = optional(string)
    cloudwatch_secret_access_key = optional(string)
    datadog_api_key              = optional(string)
    datadog_region               = optional(string)
    grafana_endpoint             = optional(string)
    grafana_password             = optional(string)
    grafana_user                 = optional(string)
    splunk_hecendpoint           = optional(string)
    splunk_token                 = optional(string)
  })

  description = "Complex Object for Audit Log Configuration. Only applied on Clusters that are on a tier higher than `dev`."

  default = {
    enabled                      = false
    cloudwatch_access_key_id     = null
    cloudwatch_region            = null
    cloudwatch_secret_access_key = null
    datadog_api_key              = null
    datadog_region               = "us1"
    grafana_endpoint             = null
    grafana_password             = null
    grafana_user                 = null
    splunk_hecendpoint           = null
    splunk_token                 = null
  }
}

variable "major_version_upgrade_config" {
  type = object({
    upgrade_type            = string
    maintenance_window_day  = optional(string)
    maintenance_window_time = optional(string)
  })

  description = "The Major Version Upgrade configuration. Only applied on Clusters of tier `standard_`, or `plus_`."
  default     = null
}

variable "metrics_config" {
  type = object({
    enabled                      = bool
    cloudwatch_access_key_id     = optional(string)
    cloudwatch_region            = optional(string)
    cloudwatch_secret_access_key = optional(string)
    datadog_api_key              = optional(string)
    datadog_region               = optional(string)
    grafana_endpoint             = optional(string)
    grafana_password             = optional(string)
    grafana_user                 = optional(string)
    splunk_hecendpoint           = optional(string)
    splunk_token                 = optional(string)
  })

  description = "Complex Object for Metrics Configuration. Only applied on Clusters that are on a tier higher than `dev`."

  default = {
    enabled                      = false
    cloudwatch_access_key_id     = null
    cloudwatch_region            = null
    cloudwatch_secret_access_key = null
    datadog_api_key              = null
    datadog_region               = "us1"
    grafana_endpoint             = null
    grafana_password             = null
    grafana_user                 = null
    splunk_hecendpoint           = null
    splunk_token                 = null
  }
}

# HCP Vault versions trail behind OSS versions of Vault for security and maintenance reasons
# see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster#schema
variable "min_vault_version" {
  type        = string
  description = "The minimum Vault version to use when creating the cluster."
  default     = null
}

# see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster#paths_filter
# and https://learn.hashicorp.com/tutorials/vault/paths-filter
variable "paths_filter" {
  type        = list(string)
  description = "The performance replication paths filter."
  default     = null
}

variable "primary_link" {
  type        = bool
  description = "The `self_link` of the HCP Vault Plus tier cluster which is the primary in the performance replication setup."
  default     = null
}

variable "proxy_endpoint" {
  type        = string
  description = "Denotes that the cluster has a proxy endpoint."
  default     = "DISABLED"

  validation {
    condition = contains([
      "DISABLED",
      "ENABLED",
    ], var.proxy_endpoint)

    error_message = "`proxy_endpoint` must be one of `DISABLED` or `ENABLED`."
  }
}

# see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster#schema
variable "public_endpoint" {
  type        = bool
  description = "Denotes that the cluster has a public endpoint."
  default     = false
}

# To enable Metrics support for HCP Vault Clusters, the cluster must be, at least, `standard_small`.
# see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster#schema
variable "tier" {
  type        = string
  description = "Tier of the HCP Vault cluster."
  default     = "dev"

  validation {
    condition = contains([
      "dev",
      "starter_small", "standard_small", "standard_medium", "standard_large",
      "plus_small", "plus_medium", "plus_large"
    ], lower(var.tier))

    error_message = "`tier` must be one of `dev`, `starter_small`, `standard_small`, `standard_medium`, `standard_large`, `plus_small`, `plus_medium`, or `plus_large`."
  }
}

variable "timeouts" {
  type = object({
    create  = string
    default = string
    delete  = string
    update  = string
  })

  description = "Amount of time (in minutes) that can elapse, before an operation is considered timed-out."

  default = {
    create  = "35m"
    default = "5m"
    delete  = "25m"
    update  = "35m"
  }
}
