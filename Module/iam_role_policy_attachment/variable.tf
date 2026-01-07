variable "role_name" {
  type = string
}

variable "policy_arn" {
  type    = string
  default = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}
