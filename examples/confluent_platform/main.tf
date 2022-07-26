module "confluent_platform" {
  source = "../../"

  namespace = var.namespace

  # assumes the confluent operator was deployed in another terraform run
  confluent_operator = {
    create = false
  }

  # uncomment to override the modules default local values
  /*
  zookeeper      = yamldecode(file("${path.module}/values/zookeeper.yaml"))
  kafka          = yamldecode(file("${path.module}/values/kafka.yaml"))
  connect        = yamldecode(file("${path.module}/values/connect.yaml"))
  ksqldb         = yamldecode(file("${path.module}/values/ksqldb.yaml"))
  controlcenter  = yamldecode(file("${path.module}/values/controlcenter.yaml"))
  schemaregistry = yamldecode(file("${path.module}/values/schemaregistry.yaml"))
  kafkarestproxy = yamldecode(file("${path.module}/values/kafkarestproxy.yaml"))
  */

  create_controlcenter = var.create_controlcenter
}
