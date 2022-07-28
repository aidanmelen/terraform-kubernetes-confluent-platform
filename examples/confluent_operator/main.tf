# https://github.com/aidanmelen/terraform-kubernetes-confluent-platform/tree/main/examples/confluent_operator
module "confluent_operator" {
  source = "../../modules/confluent_operator"

  create_namespace = true
  namespace        = "confluent"
  name             = "confluent-operator"
  chart_version    = "0.517.12"
}
