resource "kubernetes_manifest" "control_center" {
  computed_fields = var.computed_fields

  manifest = {
    "apiVersion" = "platform.confluent.io/v1beta1"
    "kind"       = "ControlCenter"
    "metadata" = merge(
      {
        "name"      = var.name
        "namespace" = var.namespace
      },
      var.additional_metadata
    )
    "spec" = var.spec
  }

  timeouts {
    create = var.create_timeout
    update = var.update_timeout
    delete = var.delete_timeout
  }
}
