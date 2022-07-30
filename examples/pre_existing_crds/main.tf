module "confluent_operator" {
  source = "../..//modules/confluent_operator"

  create_namespace = true
  namespace        = var.namespace
  name             = "confluent-operator"
  chart_version    = "0.517.12"
}

module "confluent_platform" {
  source = "../../"

  namespace             = module.confluent_operator.namespace
  create                = true
  create_zookeeper      = true
  create_kafka          = true
  create_connect        = false
  create_ksqldb         = false
  create_controlcenter  = false
  create_schemaregistry = false
  create_kafkarestproxy = false
}
