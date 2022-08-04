output "schema_object_spec" {
  description = "The Schema object spec."
  value       = module.schema.object["spec"]
}

output "schema_config_map_data" {
  description = "The Schema ConfigMap data."
  value       = jsonencode(module.schema.config_map.data)
}
