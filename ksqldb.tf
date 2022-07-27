locals {
  default_ksqldb = yamldecode(
    <<EOF
apiVersion: platform.confluent.io/v1beta1
kind: KsqlDB
metadata:
  name: ksqldb
  namespace: ${local.namespace}
spec:
  replicas: 1
  image:
    application: confluentinc/cp-ksqldb-server:7.2.0
    init: confluentinc/confluent-init-container:2.4.0
  dataVolumeCapacity: 10Gi
  EOF
  )
}

module "ksqldb" {
  source = "Invicton-Labs/deepmerge/null"
  count  = var.create_ksqldb ? 1 : 0
  maps = [
    local.default_ksqldb,
    var.ksqldb != null ? var.ksqldb : {}
  ]
}

resource "kubernetes_manifest" "ksqldb" {
  count           = var.create_ksqldb ? 1 : 0
  computed_fields = ["metadata.finalizers"]
  manifest        = module.ksqldb[0].merged

  wait {
    fields = {
      "status.phase" = "RUNNING"
    }
  }
}
