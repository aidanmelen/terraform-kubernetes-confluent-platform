# terraform_confluent_for_kubernetes/examples/quickstart_deploy/confluent_platform
module "confluent_platform" {
  source    = "../../../"
  namespace = var.namespace

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
