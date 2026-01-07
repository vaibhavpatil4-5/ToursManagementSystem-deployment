variable "vpc_id" {
  type = string
}

variable "http_cidr" {
  type = string
  default     = "0.0.0.0/0"
}

variable "ssh_cidr" {
  type = string
  default     = "0.0.0.0/0"
}
variable "egress_cidr" {
  type = string
  default     = "0.0.0.0/0"
}

