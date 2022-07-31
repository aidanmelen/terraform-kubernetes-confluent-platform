output "manifest" {
  description = "The Kafka Topic manifest."
  value       = kubernetes_manifest.topic.manifest
}

output "server_manifest" {
  description = "The Kafka Topic manifest from the Kubernetes server."
  value       = data.kubernetes_resource.topic
}
