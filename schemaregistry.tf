locals {
  default_schemaregistry = yamldecode(
    <<EOF
apiVersion: platform.confluent.io/v1beta1
kind: SchemaRegistry
metadata:
  name: schemaregistry
  namespace: ${local.namespace}
spec:
  replicas: 3
  image:
    application: confluentinc/cp-schema-registry:7.2.0
    init: confluentinc/confluent-init-container:2.4.0
  EOF
  )
}

module "schemaregistry" {
  source = "Invicton-Labs/deepmerge/null"
  count  = var.create_schemaregistry ? 1 : 0
  maps = [
    local.default_schemaregistry,
    var.schemaregistry != null ? var.schemaregistry : {}
  ]
}

resource "kubernetes_manifest" "schemaregistry" {
  count           = var.create_schemaregistry ? 1 : 0
  computed_fields = ["metadata.finalizers"]
  manifest        = module.schemaregistry[0].merged

  wait {
    fields = {
      "status.phase" = "RUNNING"
    }
  }
}
