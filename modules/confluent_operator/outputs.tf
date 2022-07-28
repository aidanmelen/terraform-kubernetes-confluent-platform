output "namespace" {
  description = "The namespace for the Confluent Operator."
  value       = local.namespace
}

output "app_version" {
  description = "The Confluent Operator app version."
  value       = helm_release.confluent_operator.metadata[0].app_version
}

output "chart_version" {
  description = "The Confluent Operator chart version."
  value       = helm_release.confluent_operator.metadata[0].version
}
