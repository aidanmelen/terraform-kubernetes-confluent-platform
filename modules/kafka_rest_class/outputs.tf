output "manifest" {
  description = "The KafkaRestClass manifest."
  value       = kubernetes_manifest.kafka_rest_class.manifest
}

output "object" {
  description = "The KafkaRestClass object."
  value       = data.kubernetes_resource.kafka_rest_class.object
}
