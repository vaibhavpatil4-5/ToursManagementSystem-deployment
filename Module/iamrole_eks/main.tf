resource "aws_iam_role" "eks_cluster_role" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = var.service_name
      }
      Action = "sts:AssumeRole"
    }]
  })
}

output "role_id" {
  value = aws_iam_role.eks_cluster_role.id
}

output "role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}
output "role_name" {
  value = aws_iam_role.eks_cluster_role.name
}
