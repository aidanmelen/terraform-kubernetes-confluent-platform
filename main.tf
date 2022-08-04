################################################################################
# Confluent Operator
################################################################################
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

################################################################################
# Confluent Platform
################################################################################
module "confluent_platform_override_values" {
  source  = "Invicton-Labs/deepmerge/null"
  version = "0.1.5"

  maps = [
    local.default_confluent_platform_values,
    local.override_confluent_platform_values
  ]
}

resource "kubernetes_manifest" "components" {
  # Terraform will invoke the Confluent Platform components and
  # the Confluent Operator will manage the creation/deletion of the custom resources.
  for_each = {
    for name, manifest in module.confluent_platform_override_values.merged : name => manifest
    if var.create && local.create_confluent_platform[name]
  }

  depends_on      = [module.confluent_operator]
  computed_fields = ["metadata.finalizers"]
  manifest        = each.value

  wait {
    fields = {
      "status.phase" = "RUNNING"
    }
  }

  timeouts {
    create = var.create_timeout
    update = var.update_timeout
    delete = var.delete_timeout
  }
}

data "kubernetes_resource" "components" {
  for_each = {
    for name, manifest in module.confluent_platform_override_values.merged : name => manifest
    if var.create && local.create_confluent_platform[name]
  }

  api_version = kubernetes_manifest.components[each.key].manifest.apiVersion
  kind        = kubernetes_manifest.components[each.key].manifest.kind

  metadata {
    name      = kubernetes_manifest.components[each.key].manifest.metadata.name
    namespace = kubernetes_manifest.components[each.key].manifest.metadata.namespace
  }
}

################################################################################
# Kafka Topics
################################################################################
module "kafka_topics" {
  source     = "./modules/kafka_topic"
  depends_on = [kubernetes_manifest.components]
  for_each   = var.kafka_topics

  name      = each.key
  namespace = lookup(each.value, "namespace", var.namespace)
  values    = lookup(each.value, "values", {})
}

################################################################################
# Schemas
################################################################################
module "schemas" {
  source     = "./modules/schema"
  depends_on = [kubernetes_manifest.components]
  for_each   = var.schemas

  name      = each.key
  namespace = lookup(each.value, "namespace", var.namespace)
  values    = lookup(each.value, "values", {})
  data      = lookup(each.value, "data", {})
}

################################################################################
# Connectors
################################################################################
module "connectors" {
  source     = "./modules/connector"
  depends_on = [kubernetes_manifest.components, module.kafka_topics, module.schemas]
  for_each   = var.connectors

  name      = each.key
  namespace = lookup(each.value, "namespace", var.namespace)
  values    = lookup(each.value, "values", {})
}
