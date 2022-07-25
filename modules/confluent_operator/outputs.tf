output "helm_release" {
  description = "The helm release for the confluent operator."
  value       = helm_release.confluent_operator
}

output "confluent_platform_versions_interoperability" {
  description = "The following describes the version compatibilities among Confluent Platform and Confluent for Kubernetes (CFK)."
  value       = local.confluent_platform_versions_interoperability
}

output "latest_confluent_platform_version_interoperability" {
  description = "The following describes the latest version compatibile among Confluent Platform and Confluent for Kubernetes (CFK)."
  value       = local.latest_confluent_platform_version_interoperability
}