resource "kubernetes_manifest" "schema_registry" {
  computed_fields = var.computed_fields

  manifest = {
    "apiVersion" = "platform.confluent.io/v1beta1"
    "kind"       = "SchemaRegistry"
    "metadata" = merge(
      {
        "name"      = var.name
        "namespace" = var.namespace
      },
      var.additional_metadata
    )
    "spec" = var.spec
  }

  wait {
    fields = {
      "status.phase" = "RUNNING"
    }
  }

  timeouts {
    create = var.create_timeout
    update = var.update_timeout
    delete = var.delete_timeout
  }
}
