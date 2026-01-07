variable "cluster_name" {
 type = string 
}
variable "role_arn" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

# This is used to ensure policy attachment happens first
variable "cluster_role_dependancy" {
  type = any
}
