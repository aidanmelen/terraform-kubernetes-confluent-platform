locals {
  default_controlcenter = yamldecode(
    <<EOF
apiVersion: platform.confluent.io/v1beta1
kind: ControlCenter
metadata:
  name: controlcenter
  namespace: ${local.namespace}
spec:
  replicas: 1
  image:
    application: confluentinc/cp-enterprise-control-center:7.2.0
    init: confluentinc/confluent-init-container:2.4.0
  dataVolumeCapacity: 10Gi
  dependencies:
    schemaRegistry:
      url: http://schemaregistry.confluent.svc.cluster.local:8081
    ksqldb:
    - name: ksqldb
      url: http://ksqldb.confluent.svc.cluster.local:8088
    connect:
    - name: connect
      url: http://connect.confluent.svc.cluster.local:8083
  EOF
  )
}

module "controlcenter" {
  source = "Invicton-Labs/deepmerge/null"
  count  = var.create_controlcenter ? 1 : 0
  maps = [
    local.default_controlcenter,
    var.controlcenter != null ? var.controlcenter : {}
  ]
}

resource "kubernetes_manifest" "controlcenter" {
  count           = var.create_controlcenter ? 1 : 0
  computed_fields = ["metadata.finalizers"]
  manifest        = module.controlcenter[0].merged

  wait {
    fields = {
      "status.phase" = "RUNNING"
    }
  }
}
