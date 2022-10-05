variable "hcp_hvn_id" {
  type        = string
  description = "HCP HVN Identifier."
  default     = "example"
}

variable "datadog_api_key" {
  type        = string
  description = "Datadog API Key."
  sensitive   = true
}
