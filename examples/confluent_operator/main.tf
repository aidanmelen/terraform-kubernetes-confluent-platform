# terraform_confluent_for_kubernetes/examples/confluent_operator/main.tf
module "confluent_operator" {
  source           = "../../modules/confluent_operator"
  name             = "confluent-operator"
  namespace        = "confluent"
  create_namespace = true
  chart_version    = "0.517.12"
}
