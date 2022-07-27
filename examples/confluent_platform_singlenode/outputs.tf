output "namespace" {
  description = "The namespace for the Confluent Platform."
  value       = module.confluent_platform_singlenode.namespace
}

output "zookeeper" {
  description = "The Zookeeper CFK manifest."
  value       = module.confluent_platform_singlenode.zookeeper_manifest
}

output "kafka" {
  description = "The Kafka CFK manifest."
  value       = module.confluent_platform_singlenode.kafka_manifest
}

output "connect" {
  description = "The Connect CFK manifest."
  value       = module.confluent_platform_singlenode.connect_manifest
}

output "ksqldb" {
  description = "The KsqlDB CFK manifest."
  value       = module.confluent_platform_singlenode.ksqldb_manifest
}

output "controlcenter" {
  description = "The ControlCenter CFK manifest."
  value       = module.confluent_platform_singlenode.controlcenter_manifest
}

output "schemaregistry" {
  description = "The SchemaRegistry CFK manifest."
  value       = module.confluent_platform_singlenode.schemaregistry_manifest
}

output "kafkarestproxy" {
  description = "The KafkaRestProxy CFK manifest."
  value       = module.confluent_platform_singlenode.kafkarestproxy_manifest
}
