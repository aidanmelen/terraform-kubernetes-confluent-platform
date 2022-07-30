output "namespace" {
  description = "The namespace for the Confluent Platform."
  value       = module.confluent_platform.namespace
}

output "confluent_operator" {
  description = "The Confluent Operator."
  value       = module.confluent_platform.confluent_operator
}

output "zookeeper" {
  description = "The Zookeeper CFK manifest."
  value       = module.confluent_platform.zookeeper_manifest
}

output "kafka" {
  description = "The Kafka CFK manifest."
  value       = module.confluent_platform.kafka_manifest
}
