output "namespace" {
  description = "The namespace for the confluent platform."
  value       = module.confluent_platform.kafka.component.manifest.metadata[0].namespace
}

output "confluent_platform" {
  description = "The confluent platform outputs."
  value       = module.confluent_platform
}

output "zookeeper" {
  description = "The Zookeeper CFK manifest."
  value       = module.confluent_platform.zookeeper.component.manifest
}

output "kafka" {
  description = "The Kafka CFK manifest."
  value       = module.confluent_platform.kafka.component.manifest
}

output "connect" {
  description = "The Connect CFK manifest."
  value       = module.confluent_platform.connect.component.manifest
}

output "ksqldb" {
  description = "The KsqlDB CFK manifest."
  value       = module.confluent_platform.ksqldb.component.manifest
}

output "control_center" {
  description = "The ControlCenter CFK manifest."
  value       = module.confluent_platform.control_center.component.manifest
}

output "schema_registry" {
  description = "The SchemaRegistry CFK manifest."
  value       = module.confluent_platform.schema_registry.component.manifest
}

output "kafka_rest_proxy" {
  description = "The KafkaRestProxy CFK manifest."
  value       = module.confluent_platform.kafka_rest_proxy.component.manifest
}
