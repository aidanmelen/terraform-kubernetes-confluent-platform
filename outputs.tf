output "namespace" {
  description = "The namespace for the Confluent Platform."
  value       = var.namespace
}

output "app_version" {
  description = "The CFK version."
  value       = try(helm_release.confluent_operator[0].metadata[0].app_version, null)
}

output "chart_version" {
  description = "The CFK version."
  value       = try(helm_release.confluent_operator[0].metadata[0].version, null)
}

output "confluent_platform_version_compatibilities" {
  description = "The version compatibilities among Confluent Platform and Confluent for Kubernetes (CFK)."
  value       = local.confluent_platform_version_compatibilities
}

output "latest_confluent_platform_version_compatibilities" {
  description = "The latest version compatibile among Confluent Platform and Confluent for Kubernetes (CFK)."
  value       = local.latest_confluent_platform_version_compatibilities
}

output "zookeeper_manifest" {
  description = "The Zookeeper manifest."
  value       = try(module.zookeeper[0].merged, null)
}

output "kafka_manifest" {
  description = "The Kafka manifest."
  value       = try(module.kafka[0].merged, null)
}

output "connect_manifest" {
  description = "The Connect manifest."
  value       = try(module.connect[0].merged, null)
}

output "ksqldb_manifest" {
  description = "The KsqlDB manifest."
  value       = try(module.ksqldb[0].merged, null)
}

output "controlcenter_manifest" {
  description = "The ControlCenter manifest."
  value       = try(module.controlcenter[0].merged, null)
}

output "schemaregistry_manifest" {
  description = "The SchemaRegistry manifest."
  value       = try(module.schemaregistry[0].merged, null)
}

output "kafkarestproxy_manifest" {
  description = "The KafkaRestProxy manifest."
  value       = try(module.kafkarestproxy[0].merged, null)
}
