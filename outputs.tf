output "namespace" {
  description = "The default namespace for the Confluent Platform."
  value       = var.namespace
}

################################################################################
# Confluent Operator
################################################################################
output "confluent_operator" {
  description = "Map of attributes for the Confluent Operator."
  value       = module.confluent_operator
}

################################################################################
# Confluent Platform
################################################################################
output "zookeeper_manifest" {
  description = "The Zookeeper manifest."
  value       = try(kubernetes_manifest.components["zookeeper"].manifest, null)
}

output "kafka_manifest" {
  description = "The Kafka manifest."
  value       = try(kubernetes_manifest.components["kafka"].manifest, null)
}

output "connect_manifest" {
  description = "The Connect manifest."
  value       = try(kubernetes_manifest.components["connect"].manifest, null)
}

output "ksqldb_manifest" {
  description = "The KsqlDB manifest."
  value       = try(kubernetes_manifest.components["ksqldb"].manifest, null)
}

output "controlcenter_manifest" {
  description = "The ControlCenter manifest."
  value       = try(kubernetes_manifest.components["controlcenter"].manifest, null)
}

output "schemaregistry_manifest" {
  description = "The SchemaRegistry manifest."
  value       = try(kubernetes_manifest.components["schemaregistry"].manifest, null)
}

output "kafkarestproxy_manifest" {
  description = "The KafkaRestProxy manifest."
  value       = try(kubernetes_manifest.components["kafkarestproxy"].manifest, null)
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
output "kafka_topics" {
  description = "Map of attribute maps for all KafkaTopic submodules created."
  value       = module.kafka_topics
}

output "kafka_topic_manifests" {
  description = "Map of attribute maps for all the KafkaTopic manifests created."
  value       = { for name, kafka_topic in module.kafka_topics : name => kafka_topic.manifest }
}

output "kafka_topic_objects" {
  description = "Map of attribute maps for all the KafkaTopic objects created."
  value       = { for name, kafka_topic in module.kafka_topics : name => kafka_topic.object }
}

################################################################################
# Kafka Rest Class
################################################################################
output "kafka_rest_classes" {
  description = "Map of attribute maps for all KafkaRestClass submodules created."
  value       = module.kafka_rest_classes
}

output "kafka_rest_class_manifests" {
  description = "Map of attribute maps for all the KafkaRestClass manifests created."
  value       = { for name, kafka_rest_class in module.kafka_rest_classes : name => kafka_rest_class.manifest }
}

output "kafka_rest_class_objects" {
  description = "Map of attribute maps for all the KafkaRestClass objects created."
  value       = { for name, kafka_rest_class in module.kafka_rest_classes : name => kafka_rest_class.object }
}

################################################################################
# Confluent Role Bindings
################################################################################
output "confluent_role_bindings" {
  description = "Map of attribute maps for all ConfluentRoleBinding submodules created."
  value       = module.confluent_role_bindings
}

output "confluent_role_binding_manifests" {
  description = "Map of attribute maps for all the ConfluentRoleBinding manifests created."
  value       = { for name, confluent_role_binding in module.confluent_role_bindings : name => confluent_role_binding.manifest }
}

output "confluent_role_binding_objects" {
  description = "Map of attribute maps for all the ConfluentRoleBinding objects created."
  value       = { for name, confluent_role_binding in module.confluent_role_bindings : name => confluent_role_binding.object }
}

################################################################################
# Schema
################################################################################
output "schemas" {
  description = "Map of attribute maps for all Schema submodules created."
  value       = module.schemas
}

output "schema_manifests" {
  description = "Map of attribute maps for all the Schema manifests created."
  value       = { for name, schema in module.schemas : name => schema.manifest }
}

output "schema_objects" {
  description = "Map of attribute maps for all the Schema objects created."
  value       = { for name, schema in module.schemas : name => schema.object }
}

output "schema_config_map" {
  description = "Map of attribute maps for all the Schema ConfigMap created."
  value       = { for name, schema in module.schemas : name => schema.config_map }
}

################################################################################
# Connectors
################################################################################
output "connectors" {
  description = "Map of attribute maps for all Connector submodules created."
  value       = module.connectors
}

output "connector_manifests" {
  description = "Map of attribute maps for all the Connector manifests created."
  value       = { for name, connector in module.connectors : name => connector.manifest }
}

output "connector_objects" {
  description = "Map of attribute maps for all the Connector objects created."
  value       = { for name, connector in module.connectors : name => connector.object }
}
