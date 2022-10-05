variable "environment" {
  type        = string
  description = "The Cloud Environment which should be used."
  default     = "public"
}

variable "location" {
  type        = string
  description = "The Azure region in which to operate"
  default     = "westus2"
}

variable "routing_table_cidrs" {
  type = list(object({
    name = string
    cidr = string
  }))

  description = "List of Objects containing Name and CIDR for (multiple) HVN Routing Tables."

  default = [
    {
      name = "Management"
      cidr = "172.16.0.0/16"
      }, {
      name = "Platform"
      cidr = "172.26.0.0/16"
    }
  ]
}
