module "confluent_platform" {
  source    = "../../"
  namespace = "confluent"

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
