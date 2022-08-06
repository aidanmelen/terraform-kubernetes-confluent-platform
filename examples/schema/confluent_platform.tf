module "confluent_platform" {
  source    = "../../"
  namespace = var.namespace

  connect = yamldecode(<<-EOF
    spec:
      replicas: 1
      build:
        type: onDemand
        onDemand:
          plugins:
            locationType: confluentHub
            confluentHub:
              - name: kafka-connect-datagen
                owner: confluentinc
                version: 0.5.2
    EOF
  )

  create_controlcenter  = var.create_controlcenter
  create_ksqldb         = false
  create_kafkarestproxy = false

  kafka_topics = {
    "pageviews" = {}
  }

  connectors = {
    # https://www.confluent.io/blog/easy-ways-generate-test-data-kafka/
    # https://raw.githubusercontent.com/confluentinc/kafka-connect-datagen/master/src/main/resources/pageviews_schema.avro
    "pageviews-avro-datagen" = {
      "values" = yamldecode(<<-EOF
        spec:
          class: "io.confluent.kafka.connect.datagen.DatagenConnector"
          taskMax: 1
          configs:
            kafka.topic: "pageviews"
            quickstart: "pageviews"
            key.converter: "org.apache.kafka.connect.storage.StringConverter"
            value.converter: "io.confluent.connect.avro.AvroConverter"
            value.converter.schemas.enable: "true"
            value.converter.schema.registry.url: "http://schemaregistry.${var.namespace}.svc.cluster.local:8081"
            max.interval: "100"
            iterations: "10000000"
        EOF
      )
    }
  }
}
