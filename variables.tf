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
    #    enabled            = bool
    #    datadog_api_key    = string #optional(string)
    #    datadog_region     = string #optional(string)
    #    grafana_endpoint   = string #optional(string)
    #    grafana_password   = string #optional(string)
    #    grafana_user       = string #optional(string)
    #    splunk_hecendpoint = string #optional(string)
    #    splunk_token       = string #optional(string)
  })

  description = "TODO"

  default = {}
}

variable "major_version_upgrade_config" {
  type = object({
    upgrade_type            = string
    maintenance_window_day  = string
    maintenance_window_time = string
  })

  description = "The Major Version Upgrade configuration."

  default = {
    upgrade_type            = "AUTOMATIC"
    maintenance_window_day  = "TUESDAY"
    maintenance_window_time = "WINDOW_12PM_4PM"
  }
}

variable "metrics_config" {
  # TODO: enable when Terraform 1.3 is released
  type = object({
    enabled         = bool
    datadog_api_key = string #optional(string)
    datadog_region  = string #optional(string)
    #    grafana_endpoint   = string #optional(string)
    #    grafana_password   = string #optional(string)
    #    grafana_user       = string #optional(string)
    #    splunk_hecendpoint = string #optional(string)
    #    splunk_token       = string #optional(string)
  })

  description = "Complex Object for Metrics Configuration."
  default = {
    enabled         = false
    datadog_api_key = null
    datadog_region  = null
    #    grafana_endpoint   = null
    #    grafana_password   = null
    #    grafana_user       = null
    #    splunk_hecendpoint = null
    #    splunk_token       = null
  }

  # see https://www.terraform.io/language/values/variables#custom-validation-rules
  validation {
    condition     = contains(["us1", "us1-fed", "us3", "us5", "eu1"], var.metrics_config.datadog_region)
    error_message = "The `datadog_region` value must be one of `us1`, `us1-fed`, `us3`, `us5`, or `eu1`."
  }
}

# HCP Vault versions trail behind OSS versions of Vault for security and maintenance reasons
# see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster#schema
variable "min_vault_version" {
  type        = string
  description = "The minimum Vault version to use when creating the cluster."
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
    condition     = contains(["dev", "starter_small", "standard_small", "standard_medium", "standard_large", "plus_small", "plus_medium", "plus_large"], var.tier)
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
