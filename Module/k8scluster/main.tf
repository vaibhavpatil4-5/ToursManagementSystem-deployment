resource "aws_eks_cluster" "ekscluster" {
    name = var.cluster_name
    role_arn = var.role_arn
    version = "1.31"

    vpc_config {
      subnet_ids = var.subnet_ids
    }
    
    access_config {
      authentication_mode = "API_AND_CONFIG_MAP"
    }

    depends_on = [  
        var.cluster_role_dependancy
    ] 
}

output "mycluster" {
 value = aws_eks_cluster.ekscluster.id
}


output "cluster_name" {
  value = aws_eks_cluster.ekscluster.name
}