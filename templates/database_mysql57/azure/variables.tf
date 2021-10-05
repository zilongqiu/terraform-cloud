variable "azure_client_id" {
  type = string
}

variable "azure_client_secret" {
  type = string
}

variable "azure_subcription_id" {
  type = string
}

variable "azure_tenant_id" {
  type = string
}

variable "mysql_image_name" {
  description = "MySQL image that will be launched by Docker"
  type        = string
  default     = "mysql:5.7"
}

variable "mysql_container_port" {
  description = "MySQL instance's port"
  type        = number
  default     = 3306
}

variable "mysql_container_name" {
  description = "MySQL container name"
  type        = string
  default     = "mysql"
}

variable "mysql_root_password" {
  description = "MySQL root user password"
  type        = string
  default     = "mypassword"
}

variable "mysql_user_name" {
  description = "MySQL user account that will be created"
  type        = string
  default     = "myuser"
}

variable "mysql_user_password" {
  description = "MySQL newly user account password that will be created"
  type        = string
  default     = "mypassword"
}

variable "mysql_database_name" {
  description = "MySQL database name"
  type        = string
  default     = "mydb"
}