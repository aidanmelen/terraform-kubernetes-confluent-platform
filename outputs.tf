output "namespace" {
  description = "The default namespace for the Confluent Platform."
  value       = var.namespace
}

output "confluent_platform_version" {
  description = "The default Confluent Platform version."
  value       = var.confluent_platform_version
}

output "zookeeper_manifest" {
  description = "The Zookeeper manifest."
  value       = try(kubernetes_manifest.component["zookeeper"].manifest, null)
}

output "kafka_manifest" {
  description = "The Kafka manifest."
  value       = try(kubernetes_manifest.component["kafka"].manifest, null)
}

output "connect_manifest" {
  description = "The Connect manifest."
  value       = try(kubernetes_manifest.component["connect"].manifest, null)
}

output "ksqldb_manifest" {
  description = "The KsqlDB manifest."
  value       = try(kubernetes_manifest.component["ksqldb"].manifest, null)
}

output "controlcenter_manifest" {
  description = "The ControlCenter manifest."
  value       = try(kubernetes_manifest.component["controlcenter"].manifest, null)
}

output "schemaregistry_manifest" {
  description = "The SchemaRegistry manifest."
  value       = try(kubernetes_manifest.component["schemaregistry"].manifest, null)
}

output "kafkarestproxy_manifest" {
  description = "The KafkaRestProxy manifest."
  value       = try(kubernetes_manifest.component["kafkarestproxy"].manifest, null)
}
