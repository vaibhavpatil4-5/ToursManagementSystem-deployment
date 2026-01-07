variable "role_name" {
  description = "Existing IAM role name"
  type        = string
}

variable "policy_arn" {
  description = "IAM policy ARN to attach to the role"
  type        = string
}
