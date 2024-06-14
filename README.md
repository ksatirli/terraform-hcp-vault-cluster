# HashiCorp Cloud Platform: HCP Vault Cluster

This Terraform Module provisions a HashiCorp Vault Cluster.

## Table of Contents

<!-- TOC -->
* [HashiCorp Cloud Platform: HCP Vault Cluster](#hashicorp-cloud-platform-hcp-vault-cluster)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Usage](#usage)
    * [Examples](#examples)
    * [Inputs](#inputs)
    * [Outputs](#outputs)
  * [Notes](#notes)
  * [Author Information](#author-information)
  * [License](#license)
<!-- TOC -->

## Requirements

* HashiCorp Cloud Platform (HCP) [Account](https://portal.cloud.hashicorp.com/sign-in)
* Terraform `1.3.0` or newer.

## Usage

> **Note**
> This module requires a [Service Principal](https://developer.hashicorp.com/hcp/docs/hcp/admin/service-principals) for HashiCorp Cloud Platform.
>
> See the [official documentation](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/guides/auth) for instructions on how to provide these credentials.

### Examples

- Deploy HCP Vault on AWS with [examples/basic-aws](https://github.com/ksatirli/terraform-hcp-vault-cluster/tree/main/examples/basic-aws).
- Deploy HCP Vault on Microsoft Azure with [examples/basic-azure](https://github.com/ksatirli/terraform-hcp-vault-cluster/tree/main/examples/basic-azure).
- Deploy HCP Vault with AWS CloudWatch Audit Log Config with [examples/audit-log-config-cloudwatch](https://github.com/ksatirli/terraform-hcp-vault-cluster/tree/main/examples/audit-log-config-cloudwatch).
- Deploy HCP Vault with AWS CloudWatch Metrics Config with [examples/metrics-log-config-cloudwatch](https://github.com/ksatirli/terraform-hcp-vault-cluster/tree/main/examples/metrics-config-cloudwatch).
- Deploy HCP Vault with Datadog Audit Logging with [examples/audit-log-config-datadog](https://github.com/ksatirli/terraform-hcp-vault-cluster/tree/main/examples/audit-log-config-datadog).
- Deploy HCP Vault with Datadog Metrics Config with [examples/metrics-config-datadog](https://github.com/ksatirli/terraform-hcp-vault-cluster/tree/main/examples/metrics-config-datadog).

For additional examples, see the [./examples](https://github.com/ksatirli/terraform-hcp-vault-cluster/tree/main/examples/) directory.

<!-- BEGIN_TF_DOCS -->
### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster_id | The ID of the HCP Vault cluster. | `string` | n/a | yes |
| hvn_id | The ID of the HVN this HCP Vault cluster is associated to. | `string` | n/a | yes |
| project_id | The ID of the HCP project where the Vault cluster is located. | `string` | n/a | yes |
| audit_log_config | Complex Object for Audit Log Configuration. Only applied on Clusters that are on a tier higher than `dev`. | <pre>object({<br>    enabled = bool<br><br>    # see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster#cloudwatch_access_key_id<br>    cloudwatch_access_key_id     = optional(string)<br>    cloudwatch_region            = optional(string)<br>    cloudwatch_secret_access_key = optional(string)<br><br>    # see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster#datadog_api_key<br>    datadog_api_key = optional(string)<br>    datadog_region  = optional(string)<br><br>    # see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster#elasticsearch_endpoint<br>    elasticsearch_endpoint = optional(string)<br>    elasticsearch_password = optional(string)<br><br>    # see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster#grafana_endpoint<br>    grafana_endpoint = optional(string)<br>    grafana_password = optional(string)<br>    grafana_user     = optional(string)<br><br>    # see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster#http_basic_password<br>    http_basic_password = optional(string)<br>    http_basic_user     = optional(string)<br>    http_bearer_token   = optional(string)<br>    http_codec          = optional(string)<br>    http_compression    = optional(bool)<br>    http_headers        = optional(map(string))<br>    http_method         = optional(string)<br>    http_payload_prefix = optional(string)<br>    http_payload_suffix = optional(string)<br>    http_uri            = optional(string)<br><br>    # see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster#newrelic_account_id<br>    newrelic_account_id  = optional(string)<br>    newrelic_license_key = optional(string)<br>    newrelic_region      = optional(string)<br><br>    # see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster#splunk_hecendpoint<br>    splunk_hecendpoint = optional(string)<br>    splunk_token       = optional(string)<br>  })</pre> | <pre>{<br>  "cloudwatch_access_key_id": null,<br>  "cloudwatch_region": null,<br>  "cloudwatch_secret_access_key": null,<br>  "datadog_api_key": null,<br>  "datadog_region": "us1",<br>  "elasticsearch_endpoint": null,<br>  "elasticsearch_password": null,<br>  "enabled": false,<br>  "grafana_endpoint": null,<br>  "grafana_password": null,<br>  "grafana_user": null,<br>  "http_basic_password": null,<br>  "http_basic_user": null,<br>  "http_bearer_token": null,<br>  "http_codec": null,<br>  "http_compression": null,<br>  "http_headers": null,<br>  "http_method": null,<br>  "http_payload_prefix": null,<br>  "http_payload_suffix": null,<br>  "http_uri": null,<br>  "newrelic_account_id": null,<br>  "newrelic_license_key": null,<br>  "newrelic_region": null,<br>  "splunk_hecendpoint": null,<br>  "splunk_token": null<br>}</pre> | no |
| ip_allowlist | Allowed IPV4 address ranges (CIDRs) for inbound traffic. Each entry must be a unique CIDR. | <pre>list(object({<br>    address     = string<br>    description = string<br>  }))</pre> | `[]` | no |
| major_version_upgrade_config | The Major Version Upgrade configuration. Only applied on Clusters of tier `standard_`, or `plus_`. | <pre>object({<br>    upgrade_type            = string<br>    maintenance_window_day  = optional(string)<br>    maintenance_window_time = optional(string)<br>  })</pre> | `null` | no |
| metrics_config | Complex Object for Metrics Configuration. Only applied on Clusters that are on a tier higher than `dev`. | <pre>object({<br>    enabled = bool<br><br>    # see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster#cloudwatch_access_key_id<br>    cloudwatch_access_key_id     = optional(string)<br>    cloudwatch_region            = optional(string)<br>    cloudwatch_secret_access_key = optional(string)<br><br>    # see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster#datadog_api_key<br>    datadog_api_key = optional(string)<br>    datadog_region  = optional(string)<br><br>    # see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster#elasticsearch_endpoint<br>    elasticsearch_endpoint = optional(string)<br>    elasticsearch_password = optional(string)<br><br>    # see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster#grafana_endpoint<br>    grafana_endpoint = optional(string)<br>    grafana_password = optional(string)<br>    grafana_user     = optional(string)<br><br>    # see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster#http_basic_password<br>    http_basic_password = optional(string)<br>    http_basic_user     = optional(string)<br>    http_bearer_token   = optional(string)<br>    http_codec          = optional(string)<br>    http_compression    = optional(bool)<br>    http_headers        = optional(map(string))<br>    http_method         = optional(string)<br>    http_payload_prefix = optional(string)<br>    http_payload_suffix = optional(string)<br>    http_uri            = optional(string)<br><br>    # see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster#newrelic_account_id<br>    newrelic_account_id  = optional(string)<br>    newrelic_license_key = optional(string)<br>    newrelic_region      = optional(string)<br><br>    # see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster#splunk_hecendpoint<br>    splunk_hecendpoint = optional(string)<br>    splunk_token       = optional(string)<br>  })</pre> | <pre>{<br>  "cloudwatch_access_key_id": null,<br>  "cloudwatch_region": null,<br>  "cloudwatch_secret_access_key": null,<br>  "datadog_api_key": null,<br>  "datadog_region": "us1",<br>  "elasticsearch_endpoint": null,<br>  "elasticsearch_password": null,<br>  "enabled": false,<br>  "grafana_endpoint": null,<br>  "grafana_password": null,<br>  "grafana_user": null,<br>  "http_basic_password": null,<br>  "http_basic_user": null,<br>  "http_bearer_token": null,<br>  "http_codec": null,<br>  "http_compression": null,<br>  "http_headers": null,<br>  "http_method": null,<br>  "http_payload_prefix": null,<br>  "http_payload_suffix": null,<br>  "http_uri": null,<br>  "newrelic_account_id": null,<br>  "newrelic_license_key": null,<br>  "newrelic_region": null,<br>  "splunk_hecendpoint": null,<br>  "splunk_token": null<br>}</pre> | no |
| min_vault_version | The minimum Vault version to use when creating the cluster. | `string` | `null` | no |
| paths_filter | The performance replication paths filter. | `list(string)` | `null` | no |
| primary_link | The `self_link` of the HCP Vault Plus tier cluster which is the primary in the performance replication setup. | `bool` | `null` | no |
| proxy_endpoint | Denotes that the cluster has a proxy endpoint. | `string` | `"DISABLED"` | no |
| public_endpoint | Denotes that the cluster has a public endpoint. | `bool` | `false` | no |
| tier | Tier of the HCP Vault cluster. | `string` | `"dev"` | no |
| timeouts | Amount of time (in minutes) that can elapse, before an operation is considered timed-out. | <pre>object({<br>    create  = string<br>    default = string<br>    delete  = string<br>    update  = string<br>  })</pre> | <pre>{<br>  "create": "35m",<br>  "default": "5m",<br>  "delete": "25m",<br>  "update": "35m"<br>}</pre> | no |

### Outputs

| Name | Description |
|------|-------------|
| cluster_audit_logs_url | HCP Vault Cluster Audit Logs URL. |
| cluster_metrics_url | HCP Vault Cluster Metrics URL. |
| cluster_overview_url | HCP Vault Cluster Overview URL. |
| cluster_replication_url | HCP Vault Cluster Replication URL. |
| cluster_snapshots_url | HCP Vault Cluster Snapshots URL. |
| hcp_vault_cluster | Exported Attributes for `hcp_vault_cluster.main` |
<!-- END_TF_DOCS -->

## Notes

This module uses Terraform's `lifecycle` [feature](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle#prevent_destroy) to prevent destruction of an HCP Vault Cluster when the corresponding Terraform module is removed.
To delete an HCP Vault Cluster, remove it from Terraform state, using the `state rm` command:

```shell
terraform state rm module.hcp_vault.hcp_vault_cluster.main
```

When done, _manually_ carry out destructive lifecycle operations through the [HCP Vault UI](https://portal.cloud.hashicorp.com/services/vault).

## Author Information

This module is maintained by the contributors listed on [GitHub](https://github.com/ksatirli/terraform-hcp-vault-cluster/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
