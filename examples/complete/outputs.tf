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
  description = "The Zookeeper object spec."
  value       = module.confluent_platform.zookeeper_object["spec"]
}

output "kafka" {
  description = "The Kafka object spec."
  value       = module.confluent_platform.kafka_object["spec"]
}

################################################################################
# Kafka Topics
################################################################################
output "kafka_topics" {
  description = "The Kafka Topic object specs."
  value       = { for name, kafka_topic in module.confluent_platform.kafka_topic_objects : name => kafka_topic.object["spec"] }
}
