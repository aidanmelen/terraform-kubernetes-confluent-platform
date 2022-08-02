locals {
  default_connector_values = yamldecode(
    <<EOF
apiVersion: platform.confluent.io/v1beta1
kind: Connector
metadata:
  name: ${var.name}
  namespace: ${var.namespace}
spec:
  taskMax: 3
  connectClusterRef:
    name: connect
  EOF
  )
}

module "connector_override_values" {
  source  = "Invicton-Labs/deepmerge/null"
  version = "0.1.5"

  maps = [
    local.default_connector_values,
    var.values
  ]
}

resource "kubernetes_manifest" "connector" {
  computed_fields = ["metadata.finalizers"]
  manifest        = module.connector_override_values.merged

  wait {
    fields = {
      "status.state" = "CREATED"
    }
  }

  timeouts {
    create = var.create_timeout
    update = var.update_timeout
    delete = var.delete_timeout
  }
}

data "kubernetes_resource" "connector" {
  api_version = kubernetes_manifest.connector.manifest.apiVersion
  kind        = kubernetes_manifest.connector.manifest.kind

  metadata {
    name      = kubernetes_manifest.connector.manifest.metadata.name
    namespace = kubernetes_manifest.connector.manifest.metadata.namespace
  }
}
