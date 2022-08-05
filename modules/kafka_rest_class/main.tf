locals {
  default_kafka_rest_class_values = yamldecode(<<-EOF
    apiVersion: platform.confluent.io/v1beta1
    kind: KafkaRestClass
    metadata:
      name: ${var.name}
      namespace: ${var.namespace}
    spec:
      kafkaClusterRef:
        name: kafka
        namespace: ${var.namespace}
  EOF
  )
}

module "kafka_rest_class_override_values" {
  source  = "Invicton-Labs/deepmerge/null"
  version = "0.1.5"

  maps = [
    local.default_kafka_rest_class_values,
    var.values
  ]
}

resource "kubernetes_manifest" "kafka_rest_class" {
  computed_fields = ["metadata.finalizers"]
  manifest        = module.kafka_rest_class_override_values.merged

  timeouts {
    create = var.create_timeout
    update = var.update_timeout
    delete = var.delete_timeout
  }
}

data "kubernetes_resource" "kafka_rest_class" {
  api_version = kubernetes_manifest.kafka_rest_class.manifest.apiVersion
  kind        = kubernetes_manifest.kafka_rest_class.manifest.kind

  metadata {
    name      = kubernetes_manifest.kafka_rest_class.manifest.metadata.name
    namespace = kubernetes_manifest.kafka_rest_class.manifest.metadata.namespace
  }
}
