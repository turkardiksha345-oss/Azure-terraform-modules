variable "location" {
  description = "Azure region location"
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnets" {
  description = "Subnets configuration"
  type = map(object({
    address_prefix = string
  }))
  default = {
    "aks-subnet" = {
      address_prefix = "10.0.1.0/24"
    }
    "vm-subnet" = {
      address_prefix = "10.0.2.0/24"
    }
  }
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}
