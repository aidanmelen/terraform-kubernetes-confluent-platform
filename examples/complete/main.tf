module "confluent_platform" {
  source = "../../"

  namespace = var.namespace

  confluent_operator = {
    create_namespace = true
    name             = "confluent-operator"
    chart_version    = "0.517.12"
  }

  zookeeper = { "spec" = { "replicas" = "3" } } # override default value
  kafka     = { "spec" = { "replicas" = "3" } } # override default value

  create_connect        = true # explictly enabled
  create_ksqldb         = false
  create_controlcenter  = false
  create_schemaregistry = false
  create_kafkarestproxy = false

  kafka_topics = {
    "my-topic" = {}
    "my-other-topic" = {
      "values" = { "spec" = { "configs" = { "cleanup.policy" = "compact" } } }
    }
  }

  connectors = {
    "my-connector" = {
      "values" = yamldecode(file("${path.module}/values/connector.yaml"))
    }
  }
}
