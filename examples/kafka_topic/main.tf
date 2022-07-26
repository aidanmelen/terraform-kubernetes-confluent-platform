module "kafka_topic" {
  source     = "../../modules/kafka_topic"
  depends_on = [module.confluent_platform]

  name      = "my-topic"
  namespace = var.namespace
}

module "other_kafka_topic" {
  source     = "../../modules/kafka_topic"
  depends_on = [module.confluent_platform]

  name      = "my-other-topic"
  namespace = var.namespace
  values = yamldecode(<<-EOF
    spec:
      partitionCount: 4
      configs:
        cleanup.policy: "compact"
      kafkaRest:
        endpoint: http://kafka.confluent.svc.cluster.local:8090
    EOF
  )
}
