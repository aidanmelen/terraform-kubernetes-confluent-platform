terraform {
  required_version = ">= 0.14.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.72"
    }

    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.12.1"
    }

    # used in crds_only.tf.example
    # kubectl = {
    #   source  = "gavinbunney/kubectl"
    #   version = ">= 1.0.0"
    # }
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
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.eks.token
}


provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}
