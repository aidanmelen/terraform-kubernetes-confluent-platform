output "app_version" {
  description = "The CFK version."
  value       = module.confluent_operator.app_version
}

output "chart_version" {
  description = "The CFK version."
  value       = module.confluent_operator.chart_version
}

output "confluent_platform_version_compatibilities" {
  description = "The version compatibilities among Confluent Platform and Confluent for Kubernetes (CFK)."
  value       = module.confluent_operator.confluent_platform_version_compatibilities
}

output "latest_confluent_platform_version_compatibility" {
  description = "The latest version compatibile among Confluent Platform and Confluent for Kubernetes (CFK)."
  value       = module.confluent_operator.latest_confluent_platform_version_compatibility
}
