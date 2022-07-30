module "confluent_operator" {
  source = "./modules/confluent_operator"
  count  = var.create ? 1 : 0

  create                = try(var.confluent_operator["create"], true)
  create_namespace      = try(var.confluent_operator["create_namespace"], true)
  namespace             = try(var.confluent_operator["namespace"], var.namespace)
  namespace_annotations = try(var.confluent_operator["namespace_annotations"], null)
  namespace_labels      = try(var.confluent_operator["namespace_labels"], null)
  name                  = try(var.confluent_operator["name"], "confluent-operator")
  repository            = try(var.confluent_operator["repository"], "https://packages.confluent.io/helm")
  chart                 = try(var.confluent_operator["chart"], "confluent-for-kubernetes")
  chart_version         = try(var.confluent_operator["chart_version"], null)
  values                = try(var.confluent_operator["values"], [])
  set                   = try(var.confluent_operator["set"], [])
  set_sensitive         = try(var.confluent_operator["set_sensitive"], [])
  wait_for_jobs         = try(var.confluent_operator["wait_for_jobs"], true)
}
