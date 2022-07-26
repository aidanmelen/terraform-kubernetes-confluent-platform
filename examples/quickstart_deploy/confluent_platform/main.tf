module "confluent_platform" {
  # source    = "terraform-kubernetes-confluent-platform/examples//quickstart_deploy/confluent_platform"
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
