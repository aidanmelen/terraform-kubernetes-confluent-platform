# https://docs.confluent.io/platform/current/installation/versions-compatibilities.html#co-long

locals {
  cfk_major = split(".", helm_release.confluent_operator.metadata[0].app_version)[0]
  cfk_minor = split(".", helm_release.confluent_operator.metadata[0].app_version)[1]

  # https://docs.confluent.io/platform/current/installation/versions-interoperability.html#confluent-operator
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
