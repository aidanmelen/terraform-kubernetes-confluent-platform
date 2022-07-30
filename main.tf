module "confluent_platform_override_values" {
  source  = "Invicton-Labs/deepmerge/null"
  version = "0.1.5"

  maps = [
    local.default_confluent_platform_values,
    local.override_confluent_platform_values
  ]
}

resource "kubernetes_manifest" "component" {
  for_each = {
    for name, manifest in module.confluent_platform_override_values.merged : name => manifest
    if var.create && local.create_confluent_platform[name]
  }

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
