resource "helm_release" "confluent_operator" {
  depends_on = [module.confluent_platform.helm_release]
  name       = "test-ldap"
  namespace  = var.namespace
  chart      = "./openldap"
}
