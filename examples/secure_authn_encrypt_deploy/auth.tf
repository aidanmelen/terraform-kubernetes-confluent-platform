################################################################################
# Confluent Component Credentials
################################################################################
resource "kubernetes_secret_v1" "credential" {
  depends_on = [module.confluent_platform.helm_release]

  metadata {
    name      = "credential"
    namespace = var.namespace
  }

  data = {
    "plain-users.json"  = trimspace(file("${path.module}/secrets/creds-kafka-sasl-users.json"))
    "digest-users.json" = trimspace(file("${path.module}/secrets/creds-zookeeper-sasl-digest-users.json"))
    "digest.txt"        = trimspace(file("${path.module}/secrets/creds-kafka-zookeeper-credentials.txt"))
    "plain.txt"         = trimspace(file("${path.module}/secrets/creds-client-kafka-sasl-user.txt"))
    "basic.txt"         = trimspace(file("${path.module}/secrets/creds-control-center-users.txt"))
  }

  type = "Opaque"
}
