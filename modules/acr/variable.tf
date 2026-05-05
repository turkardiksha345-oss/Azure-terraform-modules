variable "acr_name" {
  description = "Name of ACR (must be globally unique and lowercase)"
}

variable "resource_group_name" {}
variable "location" {}

variable "sku" {
  description = "ACR SKU (Basic, Standard, Premium)"
  default     = "Standard"
}

variable "admin_enabled" {
  description = "Enable admin user"
  default     = false
}

# For AKS integration
variable "aks_kubelet_identity" {
  description = "AKS kubelet identity object ID (optional)"
  default     = ""
}

variable "tags" {
  type = map(string)
  default = {}
}