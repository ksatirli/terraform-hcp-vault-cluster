locals {
  identifier = "hvn"
}

# get information about main subscription
# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription
data "azurerm_subscription" "main" {
  # alternatively, request information about a different subscription
  # by uncommenting the next line and manually passing in a Subscription ID
  # subscription_id = "..."
}

# create a Resource Group for use with the HVN
# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
resource "azurerm_resource_group" "main" {
  name     = local.identifier
  location = var.location
}

resource "azurerm_route_table" "main" {
  name                = local.identifier
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
}

# Set up DDoS plan; note that Azure limits the amount of plans to one per region
# Enabling DDoS protection results in meeting Best Practices as defined by Snyk: https://snyk.io/security-rules/SNYK-CC-AZURE-516
# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_ddos_protection_plan
resource "azurerm_network_ddos_protection_plan" "main" {
  location            = azurerm_resource_group.main.location
  name                = local.identifier
  resource_group_name = azurerm_resource_group.main.name
}

# create virtual network for use with the HVN
# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
resource "azurerm_virtual_network" "main" {
  address_space = [
    "10.0.0.0/16"
  ]

  name                = local.identifier
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  # Enabling DDoS protection results in meeting Best Practices as defined by Snyk: https://snyk.io/security-rules/SNYK-CC-AZURE-516
  # see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network#ddos_protection_plan
  ddos_protection_plan {
    id     = azurerm_network_ddos_protection_plan.main.id
    enable = true
  }

  # ⚠️ This example does not include a security group configuration
  # and may therefore not meet your organization's security posture.
}

resource "azurerm_network_security_group" "main" {
  name                = local.identifier
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
}

# see https://registry.terraform.io/modules/ksatirli/hvn-azure/hcp/
module "hvn_azure" {
  source  = "ksatirli/hvn-azure/hcp"
  version = "1.0.0"

  identifier          = "azure-${var.location}"
  cidr_block          = "172.25.16.0/20"
  region              = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  routing_table_cidrs = var.routing_table_cidrs
  subscription_id     = data.azurerm_subscription.main.subscription_id
  tenant_id           = data.azurerm_subscription.main.tenant_id
  vnet_name           = azurerm_virtual_network.main.name
}
