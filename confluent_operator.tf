# https://docs.confluent.io/platform/current/installation/versions-interoperability.html#confluent-operator
locals {
  cfk_app_version = try(helm_release.confluent_operator[0].metadata[0].app_version, "2.4.0")

  versions_compatibilities_map = {
    "2.4.0" = {
      "confluent_platform" = ["7.1.0", "7.2.0"]
    }
    "2.3.0" = {
      "confluent_platform" = ["7.0.0", "7.1.0"]
    }
    "2.2.0" = {
      "confluent_platform" = ["6.2.0", "7.0.0"]
    }
    "2.1.0" = {
      "confluent_platform" = ["6.0.0", "6.1.0", "6.2.0"]
    }
    "2.0.0" = {
      "confluent_platform" = ["6.0.0", "6.1.0", "6.2.0"]
    }
  }

  confluent_platform_version_compatibilities      = local.versions_compatibilities_map[local.cfk_app_version]["confluent_platform"]
  latest_confluent_platform_version_compatibility = local.confluent_platform_version_compatibilities[length(local.confluent_platform_version_compatibilities) - 1]
}

resource "helm_release" "confluent_operator" {
  count            = var.create_confluent_operator ? 1 : 0
  name             = var.confluent_operator_name
  namespace        = var.namespace
  create_namespace = false # see namespace.tf
  chart            = var.confluent_operator_chart
  version          = var.confluent_operator_chart_version
  repository       = var.confluent_operator_repository
  wait_for_jobs    = var.confluent_operator_wait_for_jobs
}
