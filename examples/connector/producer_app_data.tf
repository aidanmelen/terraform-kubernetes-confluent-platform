# https://github.com/confluentinc/confluent-kubernetes-examples/blob/806b0f1a9664b17261f600e2a48106804bef89f5/security/plaintext-basic-auth-control-Center/producer-app-data.yaml

resource "kubernetes_secret_v1" "kafka_client_config" {
  metadata {
    name      = "kafka-client-config"
    namespace = var.namespace
  }

  data = {
    "kafka.properties" = "bootstrap.servers=kafka.${var.namespace}.svc.cluster.local:9092"
  }

  type = "Opaque"
}

resource "kubernetes_stateful_set_v1" "producer" {
  depends_on = [module.connector]

  metadata {
    name      = "producer"
    namespace = var.namespace
  }

  spec {
    pod_management_policy = "Parallel"
    replicas              = 1

    selector {
      match_labels = {
        app = "producer"
      }
    }

    service_name = "producer"

    template {
      metadata {
        labels = {
          app = "producer"
        }
      }

      spec {
        container {
          name  = "producer"
          image = "confluentinc/cp-kafka:latest"

          command = [
            "/bin/sh",
            "-c",
            <<-EOF
            kafka-producer-perf-test \
              --topic ${module.confluent_platform.kafka_topic_manifests["my-topic"].metadata.name} \
              --record-size 64 \
              --throughput 1 \
              --producer.config /mnt/kafka.properties \
              --num-records ${var.producer_num_records}
            EOF
          ]

          volume_mount {
            name       = "kafka-properties"
            mount_path = "/mnt"
            read_only  = true
          }

          resources {
            requests = {
              cpu    = "500m"
              memory = "512Mi"
            }
          }
        }

        volume {
          name = "kafka-properties"

          secret {
            secret_name = kubernetes_secret_v1.kafka_client_config.metadata[0].name
          }
        }
      }
    }
  }
}
