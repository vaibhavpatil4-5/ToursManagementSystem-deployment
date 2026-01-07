resource "aws_iam_role" "eks-node-role" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

output "name" {
  value = aws_iam_role.eks-node-role.name
}

output "role_arn" {
  value = aws_iam_role.eks-node-role.arn
}
