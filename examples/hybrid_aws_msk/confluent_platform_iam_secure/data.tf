data "aws_eks_cluster" "eks" {
  name = var.name
}

data "aws_eks_cluster_auth" "eks" {
  name = var.name
}

data "aws_iam_role" "aws_msk_full_access" {
  name = "confluent-platform"
}

data "aws_msk_cluster" "msk" {
  cluster_name = var.name
}
