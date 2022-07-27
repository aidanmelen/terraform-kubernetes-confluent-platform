output "namespace" {
  description = "The namespace for the Confluent Platform."
  value       = module.confluent_platform.namespace
}

output "zookeeper" {
  description = "The Zookeeper CFK manifest."
  value       = module.confluent_platform.zookeeper_manifest
}

output "kafka" {
  description = "The Kafka CFK manifest."
  value       = module.confluent_platform.kafka_manifest
}

output "connect" {
  description = "The Connect CFK manifest."
  value       = module.confluent_platform.connect_manifest
}

output "ksqldb" {
  description = "The KsqlDB CFK manifest."
  value       = module.confluent_platform.ksqldb_manifest
}

output "controlcenter" {
  description = "The ControlCenter CFK manifest."
  value       = module.confluent_platform.controlcenter_manifest
}

output "schemaregistry" {
  description = "The SchemaRegistry CFK manifest."
  value       = module.confluent_platform.schemaregistry_manifest
}

output "kafkarestproxy" {
  description = "The KafkaRestProxy CFK manifest."
  value       = module.confluent_platform.kafkarestproxy_manifest
}
