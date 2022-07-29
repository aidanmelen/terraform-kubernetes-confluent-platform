resource "kubernetes_namespace_v1" "namespace" {
  count = var.create && var.create_namespace ? 1 : 0

  metadata {
    annotations = var.namespace_annotations
    labels      = var.namespace_labels
    name        = var.namespace
  }
}

locals {
  namespace = var.create_namespace ? kubernetes_namespace_v1.namespace[0].metadata[0].name : var.namespace
}
