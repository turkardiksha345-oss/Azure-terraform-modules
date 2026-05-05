variable "kv_name" {}
variable "location" {}
variable "resource_group_name" {}

variable "example_secret_value" {
  sensitive = true
  default   = "my-secret-value"
}

variable "tags" {
  type    = map(string)
  default = {}
}