output "helm_release" {
  description = "The helm release for the confluent operator."
  value       = helm_release.confluent_operator
}
