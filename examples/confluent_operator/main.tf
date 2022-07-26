module "confluent_operator" {
  # source    = "terraform-kubernetes-confluent-platform/examples//confluent_operator"
  source           = "../../modules/confluent_operator"
  name             = "confluent-operator"
  namespace        = "confluent"
  create_namespace = true
  chart_version    = "0.517.12"
}
