variable "ec_sb_id" {
  type = string
}
variable "ami" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "security_group_id" {
  type = string
}
variable "associate_public_ip_address" {
    type = string
}

variable "key_name" {
  type        = string
  description = "Key pair name for SSH access"
}

