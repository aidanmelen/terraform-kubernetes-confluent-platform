output "kafka_topic_manifest" {
  description = "The Kafka Topic manifest."
  value       = module.kafka_topic.manifest
}

output "other_kafka_topic_manifest" {
  description = "The Kafka Topic manifest."
  value       = module.other_kafka_topic.manifest
}
