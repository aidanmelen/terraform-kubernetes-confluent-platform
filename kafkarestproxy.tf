locals {
  default_kafkarestproxy = yamldecode(
    <<EOF
apiVersion: platform.confluent.io/v1beta1
kind: KafkaRestProxy
metadata:
  name: kafkarestproxy
  namespace: ${local.namespace}
spec:
  replicas: 1
  image:
    application: confluentinc/cp-kafka-rest:7.2.0
    init: confluentinc/confluent-init-container:2.4.0
  dependencies:
    schemaRegistry:
      url: http://schemaregistry.confluent.svc.cluster.local:8081
  EOF
  )
}

module "kafkarestproxy" {
  count  = var.create_kafkarestproxy ? 1 : 0
  source = "Invicton-Labs/deepmerge/null"
  maps = [
    local.default_kafkarestproxy,
    var.kafkarestproxy != null ? var.kafkarestproxy : {}
  ]
}

resource "kubernetes_manifest" "kafkarestproxy" {
  count           = var.create_kafkarestproxy ? 1 : 0
  computed_fields = ["metadata.finalizers"]
  manifest        = module.kafkarestproxy[0].merged

  wait {
    fields = {
      "status.phase" = "RUNNING"
    }
  }
}
