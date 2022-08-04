output "schema_config" {
  description = "The ConfigMap containing the Schema config."
  value       = kubernetes_config_map_v1.schema_config
}

output "manifest" {
  description = "The Schema manifest."
  value       = kubernetes_manifest.schema.manifest
}

output "object" {
  description = "The Schema object."
  value       = data.kubernetes_resource.schema.object
}
