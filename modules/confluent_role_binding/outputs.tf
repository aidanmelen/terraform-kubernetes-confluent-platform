output "manifest" {
  description = "The ConfluentRoleBinding manifest."
  value       = kubernetes_manifest.confluent_role_binding.manifest
}

output "object" {
  description = "The ConfluentRoleBinding object."
  value       = data.kubernetes_resource.confluent_role_binding.object
}
