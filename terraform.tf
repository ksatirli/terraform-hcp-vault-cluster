terraform {
  # see https://developer.hashicorp.com/terraform/language/settings#specifying-provider-requirements
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = ">= 0.76.0, < 1.0.0"
    }
  }

  # see https://developer.hashicorp.com/terraform/language/settings#specifying-a-required-terraform-version
  required_version = ">= 1.3.0"
}
