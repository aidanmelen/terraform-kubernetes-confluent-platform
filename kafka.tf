locals {
  default_kafka = yamldecode(
    <<EOF
apiVersion: platform.confluent.io/v1beta1
kind: Kafka
metadata:
  name: kafka
  namespace: ${local.namespace}
spec:
  replicas: 3
  image:
    application: confluentinc/cp-server:7.2.0
    init: confluentinc/confluent-init-container:2.4.0
  dataVolumeCapacity: 10Gi
  metricReporter:
    enabled: true
  EOF
  )
}

module "kafka" {
  source = "Invicton-Labs/deepmerge/null"
  count  = var.create_kafka ? 1 : 0
  maps = [
    local.default_kafka,
    var.kafka != null ? var.kafka : {}
  ]
}

resource "kubernetes_manifest" "kafka" {
  count           = var.create_kafka ? 1 : 0
  computed_fields = ["metadata.finalizers"]
  manifest        = module.kafka[0].merged

  wait {
    fields = {
      "status.phase" = "RUNNING"
    }
  }
}
