locals {
  default_zookeeper = yamldecode(
    <<EOF
apiVersion: platform.confluent.io/v1beta1
kind: Zookeeper
metadata:
  name: zookeeper
  namespace: ${local.namespace}
spec:
  replicas: 3
  image:
    application: confluentinc/cp-zookeeper:7.2.0
    init: confluentinc/confluent-init-container:2.4.0
  dataVolumeCapacity: 10Gi
  logVolumeCapacity: 10Gi
  EOF
  )
}

module "zookeeper" {
  source = "Invicton-Labs/deepmerge/null"
  count  = var.create_zookeeper ? 1 : 0
  maps = [
    local.default_zookeeper,
    var.zookeeper != null ? var.zookeeper : {}
  ]
}

resource "kubernetes_manifest" "zookeeper" {
  count           = var.create_zookeeper ? 1 : 0
  computed_fields = ["metadata.finalizers"]
  manifest        = module.zookeeper[0].merged

  wait {
    fields = {
      "status.phase" = "RUNNING"
    }
  }
}
