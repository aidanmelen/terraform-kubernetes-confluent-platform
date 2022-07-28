# https://github.com/aidanmelen/terraform-kubernetes-confluent-platform/tree/main/examples/confluent_platform
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
