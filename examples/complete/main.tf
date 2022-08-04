module "confluent_platform" {
  source = "../../"

  namespace = var.namespace

  confluent_operator = {
    create_namespace = true
    name             = "confluent-operator"
    chart_version    = "0.517.12"
  }

  # hcl value overrides
  zookeeper = { "spec" = { "replicas" = "3" } }

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
  create_schemaregistry = true # create with default values
  create_kafkarestproxy = false

  kafka_topics = {
    "pageviews" = {}
    "my-other-topic" = {
      "values" = { "spec" = { "configs" = { "cleanup.policy" = "compact" } } }
    }
  }

  schemas = {
    "pageviews-value" = {
      "data" = file("${path.module}/schemas/pageviews_schema.avro")
    }
  }

  connectors = {
    "pageviews-source" = {
      "values" = yamldecode(file("${path.module}/values/connector.yaml"))
    }
  }
}
