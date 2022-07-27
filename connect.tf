locals {
  default_connect = yamldecode(
    <<EOF
apiVersion: platform.confluent.io/v1beta1
kind: Connect
metadata:
  name: connect
  namespace: ${local.namespace}
spec:
  replicas: 1
  image:
    application: confluentinc/cp-server-connect:7.2.0
    init: confluentinc/confluent-init-container:2.4.0
  dependencies:
    kafka:
      bootstrapEndpoint: kafka:9071
  EOF
  )
}

module "connect" {
  source = "Invicton-Labs/deepmerge/null"
  count  = var.create_connect ? 1 : 0
  maps = [
    local.default_connect,
    var.connect != null ? var.connect : {}
  ]
}

resource "kubernetes_manifest" "connect" {
  count           = var.create_connect ? 1 : 0
  computed_fields = ["metadata.finalizers"]
  manifest        = module.connect[0].merged

  wait {
    fields = {
      "status.phase" = "RUNNING"
    }
  }
}
