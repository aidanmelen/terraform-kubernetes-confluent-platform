# terraform_confluent_for_kubernetes/examples/quickstart_deploy/confluent_platform/main.tf
module "confluent_platform" {
  source    = "../../../"
  namespace = "confluent"

  /*
  zookeeper_spec        = { ... }
  kafka_spec            = { ... }
  connect_spec          = { ... }
  ksqldb_spec           = { ... }
  control_center_spec   = { ... }
  schema_registry_spec  = { ... }
  kafka_rest_proxy_spec = { ... }
  */
}
