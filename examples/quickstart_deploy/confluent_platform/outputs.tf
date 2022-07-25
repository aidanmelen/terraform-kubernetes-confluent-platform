output "namespace" {
  description = "The namespace for the confluent platform."
  value       = module.confluent_operator.helm_release.namespace
}
