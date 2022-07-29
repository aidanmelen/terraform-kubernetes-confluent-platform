output "namespace" {
  description = "The namespace for the Confluent Operator."
  value       = local.namespace
}

output "app_version" {
  description = "The Confluent Operator app version."
  value       = try(helm_release.confluent_operator[0].metadata[0].app_version, null)
}

output "chart_version" {
  description = "The Confluent Operator chart version."
  value       = try(helm_release.confluent_operator[0].metadata[0].version, null)
}
