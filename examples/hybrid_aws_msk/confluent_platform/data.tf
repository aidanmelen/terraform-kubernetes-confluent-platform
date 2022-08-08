data "aws_eks_cluster" "eks" {
  name = var.name
}

data "aws_msk_cluster" "msk" {
  cluster_name = var.name
}
