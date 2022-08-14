terraform {
  required_version = ">= 0.14.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.72"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.12.1"
    }

    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0.1"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Example    = "hybrid_aws_msk"
      GithubRepo = "terraform-kubernetes-confluent-platform"
      GithubOrg  = "aidanmelen"
    }
  }
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}

provider "tls" {}
