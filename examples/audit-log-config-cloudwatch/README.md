# Example: `audit-log-config-cloudwatch`

This is a _audit-log-config-cloudwatch_ example of the `terraform-hcp-vault-cluster` module.

<!-- BEGIN_TF_DOCS -->
### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cloudwatch_access_key_id | AWS Access Key for CloudWatch Metrics Logs. | `string` | n/a | yes |
| cloudwatch_secret_access_key | AWS Secret Access Key for CloudWatch Metrics Logs. | `string` | n/a | yes |
| hcp_hvn_id | HCP HVN Identifier. | `string` | `"example"` | no |

### Outputs

No outputs.
<!-- END_TF_DOCS -->
