data "aws_eks_cluster_auth" "eks" {
  name = var.name
}
