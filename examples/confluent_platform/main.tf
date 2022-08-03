module "confluent_platform" {
  source    = "../../"
  namespace = var.namespace

  # assumes the confluent operator was deployed in another terraform run.
  confluent_operator = {
    create = false
  }

  # Uncomment to override default values
  /*
  zookeeper      = yamldecode(file("${path.module}/values/zookeeper.yaml"))
  kafka          = yamldecode(file("${path.module}/values/kafka.yaml"))
  connect        = yamldecode(file("${path.module}/values/connect.yaml"))
  ksqldb         = yamldecode(file("${path.module}/values/ksqldb.yaml"))
  controlcenter  = yamldecode(file("${path.module}/values/controlcenter.yaml"))
  schemaregistry = yamldecode(file("${path.module}/values/schemaregistry.yaml"))
  kafkarestproxy = yamldecode(file("${path.module}/values/kafkarestproxy.yaml"))
  */
}
