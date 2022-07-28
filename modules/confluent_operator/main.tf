resource "helm_release" "confluent_operator" {
  name             = var.name
  namespace        = local.namespace
  create_namespace = false # see namespace.tf
  chart            = var.chart
  version          = var.chart_version
  repository       = var.repository
  wait_for_jobs    = var.wait_for_jobs
}
