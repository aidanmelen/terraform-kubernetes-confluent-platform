module "confluent_platform" {
  source    = "../../"
  namespace = var.namespace

  # this is for demostration purposes only
  # this connector is not used in this example
  connect = yamldecode(<<EOF
spec:
  build:
    type: onDemand
    onDemand:
      plugins:
        locationType: confluentHub
        confluentHub:
          - name: debezium-connector-postgresql
            owner: debezium
            version: 1.9.3
    EOF
  )

  # disable componentes not needed for examples
  create_controlcenter  = var.create_controlcenter
  create_ksqldb         = false
  create_schemaregistry = false
  create_kafkarestproxy = false

  kafka_topics = {
    "my-topic" = {} # this topic will be mirrored to 'self.my-topic' using the connector
  }
}
