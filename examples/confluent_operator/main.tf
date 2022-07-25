module "confluent_operator" {
  source           = "../../modules/confluent_operator"
  namespace        = var.namespace
  create_namespace = true
  chart_version    = "0.517.12"
}
