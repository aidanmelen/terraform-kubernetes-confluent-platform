resource "kubernetes_config_map_v1" "schema_config" {
  metadata {
    name = "${var.name}-config"
  }

  data = {
    "schema" = var.schema
  }
}

resource "kubernetes_manifest" "schema" {
  computed_fields = var.computed_fields

  manifest = {
    "apiVersion" = "platform.confluent.io/v1beta1"
    "kind"       = "Schema"
    "metadata" = merge(
      {
        "name"      = var.name
        "namespace" = var.namespace
      },
      var.additional_metadata
    )
    "spec" = {
      "data" = {
        "configRef" = kubernetes_config_map_v1.schema_config.metadata[0].name
        "format"    = var.format
      }
    }
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
