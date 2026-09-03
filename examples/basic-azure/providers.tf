# The AzureAD Provider is set to retrieve configuration from the executing environment
# see https://registry.terraform.io/providers/hashicorp/azuread/2.51.0/docs#example-usage
provider "azuread" {
  environment = var.environment
}

# The AzureRM Provider is set to retrieve configuration from the executing environment
# see https://registry.terraform.io/providers/hashicorp/azurerm/3.107.0/docs#example-usage
provider "azurerm" {
  environment = var.environment

  features {}
}

# The HCP Provider is set to retrieve configuration from the executing environment
# see https://registry.terraform.io/providers/hashicorp/hcp/0.114.0/docs#schema
provider "hcp" {}
