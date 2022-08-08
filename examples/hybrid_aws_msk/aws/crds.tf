resource "kubectl_manifest" "crds" {
  for_each = toset([
    "platform.confluent.io_clusterlinks.yaml",
    "platform.confluent.io_confluentrolebindings.yaml",
    "platform.confluent.io_connectors.yaml",
    "platform.confluent.io_connects.yaml",
    "platform.confluent.io_controlcenters.yaml",
    "platform.confluent.io_kafkarestclasses.yaml",
    "platform.confluent.io_kafkarestproxies.yaml",
    "platform.confluent.io_kafkas.yaml",
    "platform.confluent.io_kafkatopics.yaml",
    "platform.confluent.io_ksqldbs.yaml",
    "platform.confluent.io_schemaexporters.yaml",
    "platform.confluent.io_schemaregistries.yaml",
    "platform.confluent.io_schemas.yaml",
    "platform.confluent.io_zookeepers.yaml"
  ])
  yaml_body = file("${path.module}/../../../crds/2.4.0/${each.key}")
}
