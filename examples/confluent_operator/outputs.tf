output "app_version" {
  description = "The CFK version."
  value       = module.confluent_operator.helm_release.metadata[0].app_version
}

output "chart_version" {
  description = "The CFK version."
  value       = module.confluent_operator.helm_release.metadata[0].version
}

output "confluent_platform_version_compatibilities" {
  description = "The following describes the version compatibilities among Confluent Platform and Confluent for Kubernetes (CFK)."
  value       = module.confluent_operator.confluent_platform_version_compatibilities
}

output "latest_confluent_platform_version_compatibilities" {
  description = "The following describes the latest version compatibile among Confluent Platform and Confluent for Kubernetes (CFK)."
  value       = module.confluent_operator.latest_confluent_platform_version_compatibilities
}
