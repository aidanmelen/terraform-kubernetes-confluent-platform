output "kafka_topic_manifest" {
  description = "The Kafka Topic manifest from the Kubernetes server."
  value       = module.kafka_topic.manifest
}

output "other_kafka_topic_server_manifest" {
  description = "The Kafka Topic manifest from the Kubernetes server."
  value       = yamlencode(module.other_kafka_topic.server_manifest)
}
