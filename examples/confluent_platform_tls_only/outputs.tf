# output "namespace" {
#   description = "The namespace for the Confluent Platform."
#   value       = try(module.confluent_platform_tls_only.namespace, null)
# }

# output "zookeeper" {
#   description = "The Zookeeper object spec."
#   value       = try(module.confluent_platform_tls_only.zookeeper_object["spec"], null)
# }

# output "kafka" {
#   description = "The Kafka object spec."
#   value       = try(module.confluent_platform_tls_only.kafka_object["spec"], null)
# }

# output "connect" {
#   description = "The Connect object spec."
#   value       = try(module.confluent_platform_tls_only.connect_object["spec"], null)
# }

# output "ksqldb" {
#   description = "The KsqlDB object spec."
#   value       = try(module.confluent_platform_tls_only.ksqldb_object["spec"], null)
# }

# output "controlcenter" {
#   description = "The ControlCenter object spec."
#   value       = try(module.confluent_platform_tls_only.controlcenter_object["spec"], null)
# }

# output "schemaregistry" {
#   description = "The SchemaRegistry object spec."
#   value       = try(module.confluent_platform_tls_only.schemaregistry_object["spec"], null)
# }

# output "kafkarestproxy" {
#   description = "The KafkaRestProxy object spec."
#   value       = try(module.confluent_platform_tls_only.kafkarestproxy_object["spec"], null)
# }
