# https://docs.confluent.io/platform/current/installation/versions-interoperability.html#confluent-operator
locals {
  cfk_major = try(split(".", helm_release.confluent_operator[0].metadata[0].app_version)[0], "2")
  cfk_minor = try(split(".", helm_release.confluent_operator[0].metadata[0].app_version)[1], "4")

  versions_compatibilities_map = {
    "2.4" = {
      "confluent_platform" = ["7.1", "7.2"]
    }
    "2.3" = {
      "confluent_platform" = ["7.0", "7.1"]
    }
    "2.2" = {
      "confluent_platform" = ["6.2", "7.0"]
    }
    "2.1" = {
      "confluent_platform" = ["6.0", "6.1", "6.2"]
    }
    "2.0" = {
      "confluent_platform" = ["6.0", "6.1", "6.2"]
    }
  }

  confluent_platform_version_compatibilities        = local.versions_compatibilities_map["${local.cfk_major}.${local.cfk_minor}"]["confluent_platform"]
  latest_confluent_platform_version_compatibilities = local.confluent_platform_version_compatibilities[length(local.confluent_platform_version_compatibilities) - 1]
}

resource "helm_release" "confluent_operator" {
  count            = var.create_confluent_operator ? 1 : 0
  name             = var.confluent_operator_name
  namespace        = local.namespace
  create_namespace = false
  chart            = var.confluent_operator_chart
  version          = var.confluent_operator_chart_version
  repository       = var.confluent_operator_repository
  wait_for_jobs    = var.confluent_operator_wait_for_jobs
}
