module "confluent_platform" {
  source = "../confluent_platform"
}

module "kafka_topic" {
  source = "../../modules/kafka_topic"

  name      = "my-topic"
  namespace = "confluent"
}

module "other_kafka_topic" {
  source = "../../modules/kafka_topic"

  name      = "my-other-topic"
  namespace = "confluent"

  values = yamldecode(<<EOF
spec:
  partitionCount: 4
  configs:
    cleanup.policy: "compact"
  kafkaRest:
    endpoint: http://kafka.confluent.svc.cluster.local:8090
  EOF
  )
}
