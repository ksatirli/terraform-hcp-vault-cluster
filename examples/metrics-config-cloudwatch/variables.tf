variable "hcp_hvn_id" {
  type        = string
  description = "HCP HVN Identifier."
  default     = "example"
}

variable "cloudwatch_access_key_id" {
  type        = string
  description = "AWS Access Key for CloudWatch Metrics Logs."
}

variable "cloudwatch_secret_access_key" {
  type        = string
  description = "AWS Secret Access Key for CloudWatch Metrics Logs."
  sensitive   = true
}
