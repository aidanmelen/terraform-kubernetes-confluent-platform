output "manifest" {
  description = "The KafkaTopic manifest."
  value       = kubernetes_manifest.topic.manifest
}

output "object" {
  description = "The KafkaTopic object."
  value       = data.kubernetes_resource.topic.object
}
