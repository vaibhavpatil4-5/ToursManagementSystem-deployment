resource "aws_iam_instance_profile" "bastion_profile" {
  name = var.nameprofile  
  role = var.role
}


output "name" {
  value = aws_iam_instance_profile.bastion_profile.name
}