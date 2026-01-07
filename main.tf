module "vpc" {
    source = "./Module/vpc"
    vpc_cidr = "10.0.0.0/16"
}

module "subnets"  {
  source = "./Module/subnets" #module path
  vpc_id = module.vpc.vpc_id #module vpc id
  cidr_block_1a= "10.0.1.0/24"
  availability_zone_1a = "us-east-1a" #module availability zone

  cidr_block_1b = "10.0.2.0/24"
  availability_zone_1b = "us-east-1b"
}

module "privatesubnet" {
  source = "./Module/privatesubnet"

  vpc_id = module.vpc.vpc_id

  cidr_block_1a               = "10.0.3.0/24"  #module private subnet cidr
  availability_zone_1a = "us-east-1a"

 private_cidr_block             = "10.0.4.0/24"
  private_availability_zone = "us-east-1b"
}

module "igw" {
  source = "./Module/igw"
  vpc_id = module.vpc.vpc_id   
}

module "routetable" {
  source = "./Module/routetable"
  igwid = module.igw.igw_id
  vpc_id = module.vpc.vpc_id
}

module "public_asso" {
  source = "./Module/public_asso"

  subnet_ids = {
    subnet_1a = module.subnets.public_subnet_ids[0] #module public subnet id usong array index
    subnet_1b = module.subnets.public_subnet_ids[1]
  }

  route_table_id = module.routetable.rw_id
}

module "eip" {
  source = "./Module/eip"
  domain =   "vpc"
}

module "natgateway" {
  source = "./Module/natgateway"
  allocation_id = module.eip.eip_id
  subnet_ids    = module.subnets.public_subnet_ids[0]
}


 module "privateroutetable" {
  source = "./Module/privateroutetable"
  nat_gw_id = module.natgateway.nat_id
  vpc_id = module.vpc.vpc_id
}

module "private_asso" {
  source = "./module/private_asso"

  subnet_ids = {
    subnet_1a = module.privatesubnet.pvt_subnet_ids[0]
    subnet_1b = module.privatesubnet.pvt_subnet_ids[1]
  }  
   pv_rt  = module.privateroutetable.pt_rt_id
}

module "security_group" {
 source = "./Module/security_group"
 vpc_id =  module.vpc.vpc_id

}

module "ec2" {
  source              = "./Module/ec2"
  ec_sb_id          = module.subnets.public_subnet_ids[0]
  ami                 = "ami-068c0051b15cdb816"
  instance_type       = "t3.micro"
  security_group_id   = module.security_group.security_group_id
  associate_public_ip_address = true  
  key_name = "bastion-key"
}

module "iamrole_eks" {
  source       = "C:/Users/dell/Desktop/TMS-PRODUCTION/Module/iamrole_eks"
  role_name    = "eks_cluster_roles"
}

module "iam_role_policy_attachment" {
  source    = "./Module/iam_role_policy_attachment"
  role_name = module.iamrole_eks.role_name
}

module "k8scluster" {
  source = "./Module/k8scluster"
  cluster_name = "my_eks_cluster"
  role_arn = module.iamrole_eks.role_arn
  subnet_ids =  module.privatesubnet.pvt_subnet_ids
  cluster_role_dependancy = module.iam_role_policy_attachment.attachment_id
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name = module.k8scluster.cluster_name
  addon_name   = "vpc-cni"
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name = module.k8scluster.cluster_name
  addon_name   = "kube-proxy"
}

resource "aws_eks_addon" "coredns" {
  cluster_name = module.k8scluster.cluster_name
  addon_name   = "coredns"
}

module "aws_eks_noderole" {
  source = "./Module/aws_eks_noderole"
  role_name = "eks-node-role"
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  role       = module.aws_eks_noderole.name 
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  role       = module.aws_eks_noderole.name 
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "ecr_readonly_policy" {
  role       = module.aws_eks_noderole.name 
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

module "node_group" {
  source = "./Module/node_group"

  cluster_name    = module.k8scluster.cluster_name
  node_group_name = "eks-node-group"

  node_role_arn = module.aws_eks_noderole.role_arn
  subnet_ids    = module.privatesubnet.pvt_subnet_ids

  desired_size = 2
  min_size     = 2
  max_size     = 2

  instance_types = ["c7i-flex.large"]
}

