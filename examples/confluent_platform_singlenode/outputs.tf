output "namespace" {
  description = "The namespace for the confluent platform."
  value       = module.confluent_platform_singlenode.kafka.component.manifest.metadata.namespace
}

output "zookeeper" {
  description = "The Zookeeper CFK manifest."
  value       = module.confluent_platform_singlenode.zookeeper.component.manifest
}

output "kafka" {
  description = "The Kafka CFK manifest."
  value       = module.confluent_platform_singlenode.kafka.component.manifest
}

output "connect" {
  description = "The Connect CFK manifest."
  value       = module.confluent_platform_singlenode.connect.component.manifest
}

output "ksqldb" {
  description = "The KsqlDB CFK manifest."
  value       = module.confluent_platform_singlenode.ksqldb.component.manifest
}

output "control_center" {
  description = "The ControlCenter CFK manifest."
  value       = module.confluent_platform_singlenode.control_center.component.manifest
}

output "schema_registry" {
  description = "The SchemaRegistry CFK manifest."
  value       = module.confluent_platform_singlenode.schema_registry.component.manifest
}

output "kafka_rest_proxy" {
  description = "The KafkaRestProxy CFK manifest."
  value       = module.confluent_platform_singlenode.kafka_rest_proxy.component.manifest
}
