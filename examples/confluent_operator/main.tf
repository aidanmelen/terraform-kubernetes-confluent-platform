terraform {
  required_version = ">= 0.14.8"

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0.0"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "docker-desktop"
  }
}

module "confluent_operator" {
  source           = "../../modules/confluent_operator"
  namespace        = var.namespace
  create_namespace = true
  chart_version    = "0.517.12"
}
