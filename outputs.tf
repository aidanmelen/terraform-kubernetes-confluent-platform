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

output "zookeeper_object" {
  description = "The Zookeeper object."
  value       = try(data.kubernetes_resource.components["zookeeper"].object, null)
}

output "kafka_object" {
  description = "The Kafka object."
  value       = try(data.kubernetes_resource.components["kafka"].object, null)
}

output "connect_object" {
  description = "The Connect object."
  value       = try(data.kubernetes_resource.components["connect"].object, null)
}

output "ksqldb_object" {
  description = "The KsqlDB object."
  value       = try(data.kubernetes_resource.components["ksqldb"].object, null)
}

output "controlcenter_object" {
  description = "The ControlCenter object."
  value       = try(data.kubernetes_resource.components["controlcenter"].object, null)
}

output "schemaregistry_object" {
  description = "The SchemaRegistry object."
  value       = try(data.kubernetes_resource.components["schemaregistry"].object, null)
}

output "kafkarestproxy_object" {
  description = "The KafkaRestProxy object."
  value       = try(data.kubernetes_resource.components["kafkarestproxy"].object, null)
}

################################################################################
# Kafka Topics
################################################################################
output "kafka_topic_objects" {
  description = "The Kafka Topic objects."
  value       = module.kafka_topics
}
