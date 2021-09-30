variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type = string
}

variable "subnet_prefix" {
  description = "cidr block for the subnet"
  type        = list
  default     = []
}