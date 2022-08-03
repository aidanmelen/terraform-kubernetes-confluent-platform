output "namespace" {
  description = "The namespace for the Confluent Platform."
  value       = module.confluent_platform.namespace
}

output "zookeeper" {
  description = "The Zookeeper object spec."
  value       = module.confluent_platform.zookeeper_object["spec"]
}

output "kafka" {
  description = "The Kafka object spec."
  value       = module.confluent_platform.kafka_object["spec"]
}

output "connect" {
  description = "The Connect object spec."
  value       = module.confluent_platform.connect_object["spec"]
}

output "ksqldb" {
  description = "The KsqlDB object spec."
  value       = module.confluent_platform.ksqldb_object["spec"]
}

output "controlcenter" {
  description = "The ControlCenter object spec."
  value       = try(module.confluent_platform.controlcenter_object["spec"], null)
}

output "schemaregistry" {
  description = "The SchemaRegistry object spec."
  value       = module.confluent_platform.schemaregistry_object["spec"]
}

output "kafkarestproxy" {
  description = "The KafkaRestProxy object spec."
  value       = module.confluent_platform.kafkarestproxy_object["spec"]
}
