################################################################################
# Confluent Component Credentials
################################################################################
resource "kubernetes_secret_v1" "credential" {
  depends_on = [module.confluent_platform.helm_release]

  metadata {
    name      = "credentials"
    namespace = var.namespace
  }

  data = {
    "plain-users.json"  = trimspace(file("${path.module}/secrets/creds-kafka-sasl-users.json"))
    "digest-users.json" = trimspace(file("${path.module}/secrets/creds-zookeeper-sasl-digest-users.json"))
    "digest.txt"        = trimspace(file("${path.module}/secrets/creds-kafka-zookeeper-credentials.txt"))
    "plain.txt"         = trimspace(file("${path.module}/secrets/creds-client-kafka-sasl-user.txt"))
    "basic.txt"         = trimspace(file("${path.module}/secrets/creds-control-center-users.txt"))
    "ldap.txt"          = trimspace(file("${path.module}/secrets/ldap.txt"))
  }

  type = "Opaque"
}


################################################################################
# MDS Token
################################################################################
# resource "kubernetes_secret_v1" "mds_token" {
#   depends_on = [module.confluent_platform.helm_release]

#   metadata {
#     name      = "mds-token"
#     namespace = var.namespace
#   }

#   data = {
#     "mdsPublicKey.pem" = trimspace(file("${path.module}/certs/mds-publickey.txt"))
#     "mdsTokenKeyPair.pem" = trimspace(file("${path.module}/certs/mds-tokenkeypair.txt"))
#   }

#   type = "Opaque"
# }


################################################################################
# RBAC Credentials
################################################################################

# Kafka RBAC credential
resource "kubernetes_secret_v1" "mds_client" {
  depends_on = [module.confluent_platform.helm_release]

  metadata {
    name      = "mds-client"
    namespace = var.namespace
  }

  data = {
    "bearer.txt" = trimspace(file("${path.module}/secrets/bearer.txt"))
  }
}

# Control Center RBAC credential
resource "kubernetes_secret_v1" "c3_mds_client" {
  depends_on = [module.confluent_platform.helm_release]

  metadata {
    name      = "c3-mds-client"
    namespace = var.namespace
  }

  data = {
    "bearer.txt" = trimspace(file("${path.module}/secrets/c3-mds-client.txt"))
  }
}

# Connect RBAC credential
resource "kubernetes_secret_v1" "connect_mds_client" {
  depends_on = [module.confluent_platform.helm_release]

  metadata {
    name      = "connect-mds-client"
    namespace = var.namespace
  }

  data = {
    "bearer.txt" = trimspace(file("${path.module}/secrets/connect-mds-client.txt"))
  }
}

# Schema Registry RBAC credential
resource "kubernetes_secret_v1" "sr_mds_client" {
  depends_on = [module.confluent_platform.helm_release]

  metadata {
    name      = "sr-mds-client"
    namespace = var.namespace
  }

  data = {
    "bearer.txt" = trimspace(file("${path.module}/secrets/sr-mds-client.txt"))
  }
}

# ksqlDB RBAC credential
resource "kubernetes_secret_v1" "ksqldb_mds_client" {
  depends_on = [module.confluent_platform.helm_release]

  metadata {
    name      = "ksqldb-mds-client"
    namespace = var.namespace
  }

  data = {
    "bearer.txt" = trimspace(file("${path.module}/secrets/ksqldb-mds-client.txt"))
  }
}

# Kafka Rest Proxy RBAC credential
resource "kubernetes_secret_v1" "krp_mds_client" {
  depends_on = [module.confluent_platform.helm_release]

  metadata {
    name      = "krp-mds-client"
    namespace = var.namespace
  }

  data = {
    "bearer.txt" = trimspace(file("${path.module}/secrets/krp-mds-client.txt"))
  }
}

# Kafka REST credential
resource "kubernetes_secret_v1" "rest_credential" {
  depends_on = [module.confluent_platform.helm_release]

  metadata {
    name      = "rest-credential"
    namespace = var.namespace
  }

  data = {
    "bearer.txt" = trimspace(file("${path.module}/secrets/bearer.txt"))
    "basic.txt"  = trimspace(file("${path.module}/secrets/bearer.txt"))
  }
}
