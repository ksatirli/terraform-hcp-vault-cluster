terraform {
  # see https://developer.hashicorp.com/terraform/language/settings#specifying-provider-requirements
  required_providers {
    # see https://registry.terraform.io/providers/hashicorp/azuread/2.45.0
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.45.0, < 3.0.0"
    }

    # see https://registry.terraform.io/providers/hashicorp/azurerm/3.80.0
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.80.0, < 4.0.0"
    }

    # see https://registry.terraform.io/providers/hashicorp/hcp/0.76.0/
    hcp = {
      source  = "hashicorp/hcp"
      version = ">= 0.76.0, < 1.0.0"
    }
  }

  # see https://developer.hashicorp.com/terraform/language/settings#specifying-a-required-terraform-version
  required_version = ">= 1.3.0"
}
