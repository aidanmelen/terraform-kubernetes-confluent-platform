module "confluent_platform" {
  source    = "../../"
  namespace = var.namespace

  create_controlcenter  = var.create_controlcenter
  create_ksqldb         = false
  create_schemaregistry = false
  create_kafkarestproxy = false

  kafka_topics = {
    "my-topic" = {} # this topic will be mirrored to 'self.my-topic' using the connector
  }
}
