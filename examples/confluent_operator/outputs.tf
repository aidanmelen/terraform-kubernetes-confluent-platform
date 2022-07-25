output "app_version" {
  description = "The CFK version."
  value       = module.confluent_platform.helm_release.metadata[0].app_version
}

output "chart_version" {
  description = "The CFK version."
  value       = module.confluent_platform.helm_release.metadata[0].version
}

output "confluent_platform_versions_interoperability" {
  description = "The following describes the version compatibilities among Confluent Platform and Confluent for Kubernetes (CFK)."
  value       = module.confluent_platform.confluent_platform_versions_interoperability
}

output "latest_confluent_platform_version_interoperability" {
  description = "The following describes the latest version compatibile among Confluent Platform and Confluent for Kubernetes (CFK)."
  value       = module.confluent_platform.latest_confluent_platform_version_interoperability
}