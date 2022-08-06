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
  private_key_pem       = tls_private_key.key.private_key_pem
  is_ca_certificate     = true
  validity_period_hours = 2400

  subject {
    country             = "US"
    province            = "CA"
    locality            = "MountainView"
    organization        = "Confluent"
    organizational_unit = "Operator"
    common_name         = "TestCA"
  }

  allowed_uses = [
    "any_extended"
  ]
}

resource "kubernetes_secret_v1" "ca_pair_sslcerts" {
  metadata {
    name      = "ca-pair-sslcerts"
    namespace = kubernetes_namespace_v1.namespace.metadata[0].name
  }

  data = {
    "tls.crt" = trimspace(tls_self_signed_cert.ca.cert_pem)
    "tls.key" = trimspace(tls_private_key.key.private_key_pem)
  }

  type = "kubernetes.io/tls"
}
