# output "namespace" {
#   description = "The namespace for the Confluent Platform."
#   value       = module.confluent_platform_components.namespace
# }

# output "connect" {
#   description = "The Connect object spec."
#   value       = module.confluent_platform_components.connect_object["spec"]
# }

# output "ksqldb" {
#   description = "The KsqlDB object spec."
#   value       = module.confluent_platform_components.ksqldb_object["spec"]
# }

# output "controlcenter" {
#   description = "The ControlCenter object spec."
#   value       = try(module.confluent_platform_components.controlcenter_object["spec"], null)
# }

# output "schemaregistry" {
#   description = "The SchemaRegistry object spec."
#   value       = module.confluent_platform_components.schemaregistry_object["spec"]
# }

# output "kafkarestproxy" {
#   description = "The KafkaRestProxy object spec."
#   value       = module.confluent_platform_components.kafkarestproxy_object["spec"]
# }
