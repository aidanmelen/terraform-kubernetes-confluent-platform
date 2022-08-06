locals {
  default_confluent_role_binding_values = yamldecode(<<-EOF
      apiVersion: platform.confluent.io/v1beta1
      kind: ConfluentRolebinding
      metadata:
        name: ${var.name}
        namespace: ${var.namespace}
      spec:
        kafkaRestClassRef:
          name: default
          namespace: ${var.namespace}
    EOF
  )
}

module "confluent_role_binding_override_values" {
  source  = "Invicton-Labs/deepmerge/null"
  version = "0.1.5"

  maps = [
    local.default_confluent_role_binding_values,
    var.values
  ]
}

resource "kubernetes_manifest" "confluent_role_binding" {
  computed_fields = ["metadata.finalizers"]
  manifest        = module.confluent_role_binding_override_values.merged

  # wait {
  #   fields = {
  #     "status.state" = "SUCCEEDED"
  #   }
  # }

  timeouts {
    create = var.create_timeout
    update = var.update_timeout
    delete = var.delete_timeout
  }
}

data "kubernetes_resource" "confluent_role_binding" {
  api_version = kubernetes_manifest.confluent_role_binding.manifest.apiVersion
  kind        = kubernetes_manifest.confluent_role_binding.manifest.kind

  metadata {
    name      = kubernetes_manifest.confluent_role_binding.manifest.metadata.name
    namespace = kubernetes_manifest.confluent_role_binding.manifest.metadata.namespace
  }
}
