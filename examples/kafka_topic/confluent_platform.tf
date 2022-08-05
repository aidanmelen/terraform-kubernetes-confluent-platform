module "confluent_platform" {
  source    = "../../"
  namespace = var.namespace


  create_connect        = false
  create_ksqldb         = false
  create_controlcenter  = false
  create_schemaregistry = false
  create_kafkarestproxy = false
}
