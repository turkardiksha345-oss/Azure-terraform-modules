variable "sql_server_name" {
  description = "SQL Server name (must be globally unique)"
  type        = string
}

variable "resource_group_name" {}
variable "location" {}

variable "admin_username" {
  description = "SQL admin username"
  type        = string
}

variable "admin_password" {
  description = "SQL admin password"
  type        = string
  sensitive   = true
}

variable "database_name" {
  description = "Database name"
  type        = string
}

variable "sku_name" {
  description = "SKU for SQL DB"
  default     = "S0"
}

variable "max_size_gb" {
  default = 2
}

variable "tags" {
  type    = map(string)
  default = {}
}