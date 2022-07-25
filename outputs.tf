output "zookeeper" {
  description = "The Zookeeper CFK component."
  value       = module.zookeeper
}

output "kafka" {
  description = "The Kafka CFK component."
  value       = module.kafka
}

output "connect" {
  description = "The Connect CFK component."
  value       = module.connect
}

output "ksqldb" {
  description = "The KsqlDB CFK component."
  value       = module.ksqldb
}

output "control_center" {
  description = "The ControlCenter CFK component."
  value       = module.control_center
}

output "schema_registry" {
  description = "The SchemaRegistry CFK component."
  value       = module.schema_registry
}

output "kafka_rest_proxy" {
  description = "The KafkaRestProxy CFK component."
  value       = module.kafka_rest_proxy
}
