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
  value       = try(module.zookeeper[0].merged, null)
}

output "kafka_manifest" {
  description = "The Kafka manifest."
  value       = try(module.kafka[0].merged, null)
}

output "connect_manifest" {
  description = "The Connect manifest."
  value       = try(module.connect[0].merged, null)
}

output "ksqldb_manifest" {
  description = "The KsqlDB manifest."
  value       = try(module.ksqldb[0].merged, null)
}

output "controlcenter_manifest" {
  description = "The ControlCenter manifest."
  value       = try(module.controlcenter[0].merged, null)
}

output "schemaregistry_manifest" {
  description = "The SchemaRegistry manifest."
  value       = try(module.schemaregistry[0].merged, null)
}

output "kafkarestproxy_manifest" {
  description = "The KafkaRestProxy manifest."
  value       = try(module.kafkarestproxy[0].merged, null)
}
