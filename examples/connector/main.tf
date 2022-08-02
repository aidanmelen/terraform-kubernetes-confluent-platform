module "confluent_platform" {
  source = "../../"

  namespace = var.namespace

  confluent_operator = {
    create_namespace = true
    name             = "confluent-operator"
    chart_version    = "0.517.12"
  }

  zookeeper = {
    "spec" = {
      "replicas" = "3"
    }
  }

  kafka = {
    "spec" = {
      "replicas" = "3"
    }
  }

  connect = yamldecode(
    <<EOF
spec:
  build:
    type: onDemand
    onDemand:
      plugins:
        locationType: confluentHub
        confluentHub:
          - name: kafka-connect-spooldir
            owner: jcustenborder
            version: 2.0.64
  EOF
  )

  create_ksqldb         = false
  create_controlcenter  = true
  create_schemaregistry = false
  create_kafkarestproxy = false

  kafka_topics = {
    "spooldir-testing-topic" = {}
  }
}

module "spooldir_source_connector" {
  source = "../../modules/connector"

  name      = "example"
  namespace = var.namespace

  # https://docs.confluent.io/kafka-connect-spooldir/current/connectors/json_source_connector.html#json-source-connector-example
  values = yamldecode(<<EOF
spec:
  class: "com.github.jcustenborder.kafka.connect.spooldir.SpoolDirJsonSourceConnector"
  taskMax: 1
  configs:
    "input.path": "/tmp"
    "input.file.pattern": "json-spooldir-source.json"
    error.path: "/tmp"
    finished.path: "/tmp"
    "halt.on.error": "false"
    schema.generation.enabled: "true"
    "topic": "spooldir-testing-topic"
  EOF
  )
}
