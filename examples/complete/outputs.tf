output "namespace" {
  description = "The namespace for the Confluent Platform."
  value       = module.confluent_platform.namespace
}

################################################################################
# Confluent Operator
################################################################################
output "confluent_operator" {
  description = "The Confluent Operator."
  value       = module.confluent_platform.confluent_operator[0]
}

################################################################################
# Confluent Platform
################################################################################
output "zookeeper_manifest" {
  description = "The Zookeeper manifest."
  value       = module.confluent_platform.zookeeper_manifest
}

output "kafka_manifest" {
  description = "The Kafka manifest."
  value       = module.confluent_platform.kafka_manifest
}

output "connect_manifest" {
  description = "The Connect manifest."
  value       = module.confluent_platform.connect_manifest
}

output "zookeeper_object_spec" {
  description = "The Zookeeper object spec."
  value       = module.confluent_platform.zookeeper_object["spec"]
}

output "kafka_object_spec" {
  description = "The Kafka object spec."
  value       = module.confluent_platform.kafka_object["spec"]
}

output "connect_object_spec" {
  description = "The Connect object spec."
  value       = module.confluent_platform.connect_object["spec"]
}


################################################################################
# Kafka Topics
################################################################################
output "kafka_topic_manifests" {
  description = "Map of attribute maps for all the KafkaTopic manifests created."
  value       = module.confluent_platform.kafka_topic_manifests
}


output "kafka_topic_object_specs" {
  description = "Map of attribute maps for all the KafkaTopic object specs created."
  value       = { for name, kafka_topic in module.confluent_platform.kafka_topic_objects : name => kafka_topic["spec"] }
}

################################################################################
# Schemas
################################################################################
output "schema_manifests" {
  description = "Map of attribute maps for all the Schema manifests created."
  value       = module.confluent_platform.schema_manifests
}

output "schema_object_specs" {
  description = "Map of attribute maps for all the Schema object specs created."
  value       = { for name, schema in module.confluent_platform.schema_objects : name => schema["spec"] }
}

output "schema_config_map_data" {
  description = "Map of attribute maps for all the Schema config data created."
  value       = { for name, config_map in module.confluent_platform.schema_config_map : name => config_map.data }
}

################################################################################
# Connectors
################################################################################
output "connector_manifests" {
  description = "Map of attribute maps for all the Connector manifests created."
  value       = module.confluent_platform.connector_manifests
}

output "connector_object_specs" {
  description = "Map of attribute maps for all the Connector object specs created."
  value       = { for name, connectors in module.confluent_platform.connector_objects : name => connectors["spec"] }
}
