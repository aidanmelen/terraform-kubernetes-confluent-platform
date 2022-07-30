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
  /*
  zookeeper      = { ... }
  kafka          = { ... }
  connect        = { ... }
  ksqldb         = { ... }
  controlcenter  = { ... }
  schemaregistry = { ... }
  kafkarestproxy = { ... }
  */
}
