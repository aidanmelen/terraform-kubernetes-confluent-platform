resource "kubernetes_config_map_v1" "schema_config" {
  metadata {
    name      = "${var.name}-config"
    namespace = var.namespace
  }

  data = {
    schema = var.schema
  }
}

locals {
  default_schema_values = yamldecode(
    <<EOF
apiVersion: platform.confluent.io/v1beta1
kind: Schema
metadata:
  name: ${var.name}
  namespace: ${var.namespace}
spec:
  data:
    configRef: ${kubernetes_config_map_v1.schema_config.metadata[0].name}
    format: avro
  EOF
  )
}

module "schema_override_values" {
  source  = "Invicton-Labs/deepmerge/null"
  version = "0.1.5"

  maps = [
    local.default_schema_values,
    var.values
  ]
}

resource "kubernetes_manifest" "schema" {
  computed_fields = ["metadata.finalizers"]
  manifest        = module.schema_override_values.merged

  wait {
    fields = {
      "status.state" = "SUCCEEDED"
    }
  }

  timeouts {
    create = var.create_timeout
    update = var.update_timeout
    delete = var.delete_timeout
  }
}

data "kubernetes_resource" "schema" {
  api_version = kubernetes_manifest.schema.manifest.apiVersion
  kind        = kubernetes_manifest.schema.manifest.kind

  metadata {
    name      = kubernetes_manifest.schema.manifest.metadata.name
    namespace = kubernetes_manifest.schema.manifest.metadata.namespace
  }
}
