module "confluent_operator" {
  source                  = "./modules/confuent_operator"
  namespace               = var.namespace
  should_create_namespace = true
}

module "zookeeper" {
  source     = "./modules/zookeeper"
  namespace  = module.confluent_operator.helm_release.namespace
  spec       = var.zookeeper_spec
  depends_on = [module.confluent_operator]
}

module "kafka" {
  source     = "./modules/kafka"
  namespace  = module.confluent_operator.helm_release.namespace
  spec       = var.kafka_spec
  depends_on = [module.zookeeper]
}

module "connect" {
  source     = "./modules/connect"
  namespace  = module.confluent_operator.helm_release.namespace
  spec       = var.connect_spec
  depends_on = [module.kafka]
}

module "ksqldb" {
  source     = "./modules/ksqldb"
  namespace  = module.confluent_operator.helm_release.namespace
  spec       = var.ksqldb_spec
  depends_on = [module.kafka]
}

module "control_center" {
  source    = "./modules/control_center"
  namespace = module.confluent_operator.helm_release.namespace
  spec      = var.control_center_spec
  depends_on = [
    module.kafka,
    module.schema_registry,
    module.connect,
    module.ksqldb
  ]
}

module "schema_registry" {
  source     = "./modules/schema_registry"
  spec       = var.schema_registry_spec
  namespace  = module.confluent_operator.helm_release.namespace
  depends_on = [module.kafka]
}

module "kafka_rest_proxy" {
  source     = "./modules/kafka_rest_proxy"
  namespace  = module.confluent_operator.helm_release.namespace
  spec       = var.kafka_rest_proxy_spec
  depends_on = [module.kafka]
}
