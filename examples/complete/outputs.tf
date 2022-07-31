output "namespace" {
  description = "The namespace for the Confluent Platform."
  value       = module.confluent_platform.namespace
}

################################################################################
# Confluent Operator
################################################################################
output "confluent_operator" {
  description = "The Confluent Operator."
  value       = module.confluent_platform.confluent_operator[0]
}

################################################################################
# Confluent Platform
################################################################################
output "zookeeper" {
  description = "The Zookeeper CFK manifest."
  value       = module.confluent_platform.zookeeper_manifest
}

output "kafka" {
  description = "The Kafka CFK manifest."
  value       = module.confluent_platform.kafka_manifest
}

################################################################################
# Kafka Topics
################################################################################
output "kafka_topics" {
  description = "The Kafka CFK manifest."
  value       = module.confluent_platform.kafka_topics
}
