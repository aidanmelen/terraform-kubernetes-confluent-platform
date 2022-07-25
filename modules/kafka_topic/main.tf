resource "kubernetes_manifest" "kafka_topic" {
  computed_fields = var.computed_fields

  manifest = {
    "apiVersion" = "platform.confluent.io/v1beta1"
    "kind"       = "KafkaTopic"
    "metadata" = merge(
      {
        "name"      = var.name
        "namespace" = var.namespace
      },
      var.additional_metadata
    )
    "spec" = {
      "replicas"        = var.replicas
      "partitionCount"  = var.partition_count
      "kafkaClusterRef" = var.kafka_cluster_ref
    }
  }

  wait {
    fields = {
      rollout = true
    }
  }

  timeouts {
    create = var.create_timeout
    update = var.update_timeout
    delete = var.delete_timeout
  }
}
