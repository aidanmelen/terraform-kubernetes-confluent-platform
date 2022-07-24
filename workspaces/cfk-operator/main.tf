resource "kubernetes_namespace_v1" "confluent" {
  count = var.should_create_namespace ? 1 : 0

  metadata {
    name = var.kubernetes_namespace
  }
}

resource "helm_release" "confluent_operator" {
  name       = "confluent-operator"
  repository = "https://packages.confluent.io/helm"
  chart      = "confluent-for-kubernetes"
  namespace  = var.should_create_namespace ? kubernetes_namespace_v1.confluent[0].metadata[0].name : var.kubernetes_namespace
}