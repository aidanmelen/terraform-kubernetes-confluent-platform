locals {
  default_kafka_topic_values = yamldecode(
    <<EOF
apiVersion: platform.confluent.io/v1beta1
kind: KafkaTopic
metadata:
  name: ${var.name}
  namespace: ${var.namespace}
spec:
  replicas: 3
  partitionCount: 3
  configs:
    cleanup.policy: "delete"
  EOF
  )
}

module "kafka_topic_override_values" {
  source  = "Invicton-Labs/deepmerge/null"
  version = "0.1.5"

  maps = [
    local.default_kafka_topic_values,
    var.values
  ]
}

resource "kubernetes_manifest" "topic" {
  computed_fields = ["metadata.finalizers"]
  manifest        = module.kafka_topic_override_values.merged

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

# data "kubernetes_resource" "topic" {
#   api_version = kubernetes_manifest.topic.manifest.apiVersion
#   kind        = kubernetes_manifest.topic.manifest.kind

#   metadata {
#     name      = kubernetes_manifest.topic.manifest.metadata.name
#     namespace = kubernetes_manifest.topic.manifest.metadata.namespace
#   }
# }
