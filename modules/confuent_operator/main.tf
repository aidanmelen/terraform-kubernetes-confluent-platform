resource "kubernetes_namespace_v1" "confluent" {
  count = var.should_create_namespace ? 1 : 0

  metadata {
    name = var.namespace
  }
}

resource "helm_release" "confluent_operator" {
  name          = var.name
  repository    = var.repository
  chart         = var.chart
  namespace     = var.should_create_namespace ? kubernetes_namespace_v1.confluent[0].metadata[0].name : var.namespace
  wait_for_jobs = var.wait_for_jobs
}
