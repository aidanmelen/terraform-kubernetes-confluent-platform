module "confluent_platform" {
  source = "../../"

  namespace = var.namespace

  confluent_operator = {
    create_namespace = true
    name             = "confluent-operator"
    chart_version    = "0.517.12"
  }

  # value overrides
  zookeeper = {
    "spec" = {
      "replicas" = "3"
    }
  }

  # yaml inline value overrides
  kafka = yamldecode(<<-EOF
    spec:
      replicas: 3
    EOF
  )

  # yaml file value overrides
  connect = yamldecode(file("${path.module}/values/connect.yaml"))

  create_ksqldb         = false
  create_controlcenter  = var.create_controlcenter
  create_schemaregistry = true # explictly create with default values
  create_kafkarestproxy = false

  kafka_topics = {
    "pageviews" = {}
    "my-other-topic" = {
      "values" = { "spec" = { "configs" = { "cleanup.policy" = "compact" } } }
    }
  }

  schemas = {
    "pageviews-value" = {
      "data" = file("${path.module}/schemas/pageviews.avro")
    }
  }

  connectors = {
    "pageviews-source" = {
      "values" = yamldecode(
        templatefile(
          "${path.module}/values/connector.yaml",
          {
            "datagen_source_connector_max_interval" : var.datagen_source_connector_max_interval,
            "datagen_source_connector_iterations" : var.datagen_source_connector_iterations
          }
        )
      )
    }
  }
}
