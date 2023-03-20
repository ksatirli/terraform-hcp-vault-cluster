terraform {
  # see https://developer.hashicorp.com/terraform/language/settings#specifying-provider-requirements
  required_providers {
    # see https://registry.terraform.io/providers/hashicorp/azurerm/3.48.0
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.48.0, < 4.0.0"
    }

    # see https://registry.terraform.io/providers/hashicorp/hcp/0.56.0/
    hcp = {
      source  = "hashicorp/hcp"
      version = ">= 0.56.0, < 1.0.0"
    }
  }

  # see https://developer.hashicorp.com/terraform/language/settings#specifying-a-required-terraform-version
  required_version = ">= 1.4.0"
}
