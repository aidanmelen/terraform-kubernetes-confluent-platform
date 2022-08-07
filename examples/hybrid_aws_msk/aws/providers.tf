terraform {
  required_version = ">= 0.14.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.72"
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
