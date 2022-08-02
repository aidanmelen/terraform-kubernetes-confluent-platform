output "manifest" {
  description = "The Connector manifest."
  value       = kubernetes_manifest.connector.manifest
}

output "object" {
  description = "The Connector object."
  value       = data.kubernetes_resource.connector.object
}
