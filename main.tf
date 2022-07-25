module "zookeeper" {
  source     = "./modules/zookeeper"
  namespace  = var.namespace
  spec       = var.zookeeper_spec
}

module "kafka" {
  source     = "./modules/kafka"
  namespace  = var.namespace
  spec       = var.kafka_spec
  depends_on = [module.zookeeper]
}

module "connect" {
  source     = "./modules/connect"
  namespace  = var.namespace
  spec       = var.connect_spec
  depends_on = [module.kafka]
}

module "ksqldb" {
  source     = "./modules/ksqldb"
  namespace  = var.namespace
  spec       = var.ksqldb_spec
  depends_on = [module.kafka]
}

module "control_center" {
  source    = "./modules/control_center"
  namespace = var.namespace
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
  namespace  = var.namespace
  depends_on = [module.kafka]
}

module "kafka_rest_proxy" {
  source     = "./modules/kafka_rest_proxy"
  namespace  = var.namespace
  spec       = var.kafka_rest_proxy_spec
  depends_on = [module.kafka]
}
