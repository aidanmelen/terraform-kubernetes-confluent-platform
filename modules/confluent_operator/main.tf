resource "helm_release" "confluent_operator" {
  name             = var.name
  namespace        = var.namespace
  create_namespace = var.create_namespace
  chart            = var.chart
  version          = var.chart_version
  repository       = var.repository
  wait_for_jobs    = var.wait_for_jobs
}
