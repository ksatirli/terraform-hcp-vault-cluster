output "hcp_vault_cluster" {
  description = "Exported Attributes for `hcp_vault_cluster.main`"
  value       = hcp_vault_cluster.main
}

locals {
  base_url        = "https://portal.cloud.hashicorp.com/services/vault/${hcp_vault_cluster.main.cluster_id}"
  project_segment = "project_id=${hcp_vault_cluster.main.project_id}"
}

output "cluster_overview_url" {
  description = "HCP Vault Cluster Overview URL."
  value       = "${local.base_url}?${local.project_segment}"
}

output "cluster_metrics_url" {
  description = "HCP Vault Cluster Metrics URL."
  value       = "${local.base_url}/metrics?${local.project_segment}"
}

output "cluster_audit_logs_url" {
  description = "HCP Vault Cluster Audit Logs URL."
  value       = "${local.base_url}/audit-logs?${local.project_segment}"
}

output "cluster_snapshots_url" {
  description = "HCP Vault Cluster Snapshots URL."
  value       = "${local.base_url}/snapshots?${local.project_segment}"
}

output "cluster_replication_url" {
  description = "HCP Vault Cluster Replication URL."
  value       = "${local.base_url}/replication?${local.project_segment}"
}
