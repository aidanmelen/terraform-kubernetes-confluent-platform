output "confluent_for_kubernetes_crds" {
  description = "The Confluent for Kubernetes CRDs (YAML)."

  # NOT IMPLEMENTED as of 07/26/2022
  # https://github.com/hashicorp/terraform-provider-helm/pull/795
  # value       = data.helm_template.confluent_for_kubernetes.manifests

  value = data.helm_template.confluent_for_kubernetes.manifests
}
