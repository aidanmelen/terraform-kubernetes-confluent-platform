module "confluent_platform" {
  source = "../../"

  namespace = var.namespace

  # confluent operator
  confluent_operator = {
    create_namespace = true
    name             = "confluent-operator"
    chart_version    = "0.517.12"
  }

  # confluent platform
  create                = true
  create_zookeeper      = true
  create_kafka          = true
  create_connect        = false
  create_ksqldb         = false
  create_controlcenter  = false
  create_schemaregistry = false
  create_kafkarestproxy = false
}
