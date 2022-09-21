# HashiCorp Cloud Platform: HCP Vault Cluster

This Terraform Module provisions a HashiCorp Vault Cluster.

> **Warning**
>
> This module is currently in a **public testing** phase; usage for production workloads is discouraged.
>
> Please report any issues and concerns via the [Issues](https://github.com/ksatirli/terraform-hcp-vault-cluster/issues) tab.

---

## Table of Contents

<!-- TOC -->
* [HashiCorp Cloud Platform: HCP Vault Cluster](#hashicorp-cloud-platform--hcp-vault-cluster)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Usage](#usage)
    * [Inputs](#inputs)
    * [Outputs](#outputs)
  * [Notes](#notes)
  * [Author Information](#author-information)
  * [License](#license)
<!-- TOC -->

## Requirements

* HashiCorp Cloud Platform (HCP) [Account](https://portal.cloud.hashicorp.com/sign-in)
* Terraform `1.3.x` or newer.

## Usage

For examples, see the [./examples](https://github.com/ksatirli/terraform-hcp-vault-cluster/tree/main/examples/) directory.

<!-- BEGIN_TF_DOCS -->
### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster_id | The ID of the HCP Vault cluster. | `string` | n/a | yes |
| hvn_id | The ID of the HVN this HCP Vault cluster is associated to. | `string` | n/a | yes |
| min_vault_version | The minimum Vault version to use when creating the cluster. | `string` | n/a | yes |
| audit_log_config | TODO | <pre>object({<br>    #    enabled            = bool<br>    #    datadog_api_key    = string #optional(string)<br>    #    datadog_region     = string #optional(string)<br>    #    grafana_endpoint   = string #optional(string)<br>    #    grafana_password   = string #optional(string)<br>    #    grafana_user       = string #optional(string)<br>    #    splunk_hecendpoint = string #optional(string)<br>    #    splunk_token       = string #optional(string)<br>  })</pre> | `{}` | no |
| major_version_upgrade_config | The Major Version Upgrade configuration. | <pre>object({<br>    upgrade_type            = string<br>    maintenance_window_day  = string<br>    maintenance_window_time = string<br>  })</pre> | <pre>{<br>  "maintenance_window_day": "TUESDAY",<br>  "maintenance_window_time": "WINDOW_12PM_4PM",<br>  "upgrade_type": "AUTOMATIC"<br>}</pre> | no |
| metrics_config | Complex Object for Metrics Configuration. | <pre>object({<br>    enabled         = bool<br>    datadog_api_key = string #optional(string)<br>    datadog_region  = string #optional(string)<br>    #    grafana_endpoint   = string #optional(string)<br>    #    grafana_password   = string #optional(string)<br>    #    grafana_user       = string #optional(string)<br>    #    splunk_hecendpoint = string #optional(string)<br>    #    splunk_token       = string #optional(string)<br>  })</pre> | <pre>{<br>  "datadog_api_key": null,<br>  "datadog_region": null,<br>  "enabled": false<br>}</pre> | no |
| paths_filter | The performance replication paths filter. | `list(string)` | `null` | no |
| primary_link | The `self_link` of the HCP Vault Plus tier cluster which is the primary in the performance replication setup. | `bool` | `null` | no |
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

This module uses Terraform's `lifecycle` [feature](https://www.terraform.io/language/meta-arguments/lifecycle#prevent_destroy) to prevent destruction of an HCP Vault Cluster when the corresponding Terraform module is removed.
To delete an HCP Vault Cluster, remove it from Terraform state, using the `state rm` command:

```shell
terraform state rm module.hcp_vault.hcp_vault_cluster.main
```

When done, manually carry out destructive lifecycle operations through the [HCP Vault UI](https://portal.cloud.hashicorp.com/services/vault).

## Author Information

This module is maintained by the contributors listed on [GitHub](https://github.com/ksatirli/terraform-hcp-vault-cluster/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
