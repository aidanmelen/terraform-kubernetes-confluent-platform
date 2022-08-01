output "kafka_topic" {
  description = "The Kafka Topic spec."
  value       = module.kafka_topic.object["spec"]
}

output "other_kafka_topic" {
  description = "The other Kafka Topic spec."
  value       = module.other_kafka_topic.object["spec"]
}
