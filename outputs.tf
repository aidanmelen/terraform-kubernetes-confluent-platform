output "namespace" {
  description = "The default namespace for the Confluent Platform."
  value       = var.namespace
}

################################################################################
# Confluent Operator
################################################################################
output "confluent_operator" {
  description = "The Confluent Operator."
  value       = module.confluent_operator
}

################################################################################
# Confluent Platform
################################################################################
output "version" {
  description = "The default Confluent Platform version."
  value       = var.confluent_platform_version
}

output "zookeeper_manifest" {
  description = "The Zookeeper manifest."
  value       = try(kubernetes_manifest.components["zookeeper"].manifest, null)
}

output "kafka_manifest" {
  description = "The Kafka manifest."
  value       = try(kubernetes_manifest.components["kafka"].manifest, null)
}

output "connect_manifest" {
  description = "The Connect manifest."
  value       = try(kubernetes_manifest.components["connect"].manifest, null)
}

output "ksqldb_manifest" {
  description = "The KsqlDB manifest."
  value       = try(kubernetes_manifest.components["ksqldb"].manifest, null)
}

output "controlcenter_manifest" {
  description = "The ControlCenter manifest."
  value       = try(kubernetes_manifest.components["controlcenter"].manifest, null)
}

output "schemaregistry_manifest" {
  description = "The SchemaRegistry manifest."
  value       = try(kubernetes_manifest.components["schemaregistry"].manifest, null)
}

output "kafkarestproxy_manifest" {
  description = "The KafkaRestProxy manifest."
  value       = try(kubernetes_manifest.components["kafkarestproxy"].manifest, null)
}

################################################################################
# Kafka Topics
################################################################################
output "kafka_topics" {
  description = "The Kafka Topic manifests"
  value       = module.kafka_topics[*]
}
