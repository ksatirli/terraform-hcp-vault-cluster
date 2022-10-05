# Example: `basic`

This is a _basic_ example of the `terraform-hcp-vault-cluster` module.

<!-- BEGIN_TF_DOCS -->
### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment | The Cloud Environment which should be used. | `string` | `"public"` | no |
| hcp_hvn_id | HCP HVN Identifier. | `string` | `"example"` | no |
| location | The Azure region in which to operate | `string` | `"westus2"` | no |
| routing_table_cidrs | List of Objects containing Name and CIDR for (multiple) HVN Routing Tables. | <pre>list(object({<br>    name = string<br>    cidr = string<br>  }))</pre> | <pre>[<br>  {<br>    "cidr": "172.16.0.0/16",<br>    "name": "Management"<br>  },<br>  {<br>    "cidr": "172.26.0.0/16",<br>    "name": "Platform"<br>  }<br>]</pre> | no |

### Outputs

No outputs.
<!-- END_TF_DOCS -->
