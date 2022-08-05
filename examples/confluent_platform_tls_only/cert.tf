resource "kubernetes_namespace_v1" "namespace" {
  metadata {
    name = var.namespace
  }
}

resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_self_signed_cert" "ca" {
  private_key_pem = tls_private_key.key.private_key_pem

  subject {
    common_name  = "example.com"
    organization = "Confluent"
  }

  validity_period_hours = 12

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "kubernetes_secret_v1" "ca_pair_sslcerts" {
  metadata {
    name      = "ca-pair-sslcerts"
    namespace = kubernetes_namespace_v1.namespace.metadata[0].name
  }

  data = {
    "tls.crt" = tls_self_signed_cert.ca.cert_pem
    "tls.key" = tls_private_key.key.private_key_pem
  }

  type = "kubernetes.io/tls"
}
