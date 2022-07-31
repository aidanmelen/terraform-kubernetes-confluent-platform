module "confluent_platform" {
  source    = "../../"
  namespace = "confluent"

  /*
  zookeeper      = yamldecode( ... )
  kafka          = yamldecode( ... )
  connect        = yamldecode( ... )
  ksqldb         = yamldecode( ... )
  controlcenter  = yamldecode( ... )
  schemaregistry = yamldecode( ... )
  kafkarestproxy = yamldecode( ... )
  */
}
