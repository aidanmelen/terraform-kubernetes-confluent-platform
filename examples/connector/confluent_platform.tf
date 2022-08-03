module "confluent_platform" {
  source    = "../../"
  namespace = var.namespace

  # example installing connector plugin on demand
  # this is not used in this example
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
  create_controlcenter  = false
  create_ksqldb         = false
  create_schemaregistry = false
  create_kafkarestproxy = false

  kafka_topics = {
    "my-topic" = {}
  }
}
