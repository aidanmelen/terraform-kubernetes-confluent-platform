data "helm_template" "confluent_for_kubernetes" {
  name         = "confluent-for-kubernetes-crds"
  namespace    = local.namespace
  chart        = var.chart
  version      = var.chart_version
  repository   = var.repository
  include_crds = true
}

resource "kubernetes_manifest" "crds" {

  # NOT IMPLEMENTED as of 07/26/2022
  # https://github.com/hashicorp/terraform-provider-helm/pull/795
  # for_each = data.helm_template.confluent_for_kubernetes.crds

  for_each = data.helm_template.confluent_for_kubernetes.manifests

  lifecycle {
    prevent_destroy = true
  }

  manifest = yamldecode(each.value)
}
