# connector

Deploy a Connector on Kafka Connect.

## Assumptions

This example assumes you have a Kubernetes cluster running locally on Docker Desktop. Please see [Docker's official documentation](https://docs.docker.com/desktop/kubernetes/) for more information.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Example

```hcl
module "confluent_platform" {
  source  = "aidanmelen/confluent-platform/kubernetes"
  version = ">= 0.6.0"

  namespace = var.namespace

  confluent_operator = {
    create_namespace = true
    name             = "confluent-operator"
    chart_version    = "0.517.12"
  }

  zookeeper = {
    "spec" = {
      "replicas" = "3"
    }
  }

  kafka = {
    "spec" = {
      "replicas" = "3"
    }
  }

  connect = yamldecode(
    <<EOF
spec:
  build:
    type: onDemand
    onDemand:
      plugins:
        locationType: confluentHub
        confluentHub:
          - name: kafka-connect-spooldir
            owner: jcustenborder
            version: 2.0.64
  EOF
  )

  create_ksqldb         = false
  create_controlcenter  = true
  create_schemaregistry = false
  create_kafkarestproxy = false

  kafka_topics = {
    "spooldir-testing-topic" = {}
  }
}

module "spooldir_source  = "aidanmelen/confluent-platform/kubernetes"
  version = ">= 0.6.0"
  source  = "aidanmelen/confluent-platform/kubernetes"
  version = ">= 0.6.0"

  name      = "example"
  namespace = var.namespace

  # https://docs.confluent.io/kafka-connect-spooldir/current/connectors/json_source  = "aidanmelen/confluent-platform/kubernetes"
  version = ">= 0.6.0"
  values = yamldecode(<<EOF
spec:
  class: "com.github.jcustenborder.kafka.connect.spooldir.SpoolDirJsonSourceConnector"
  taskMax: 1
  configs:
    "input.path": "/tmp"
    "input.file.pattern": "json-spooldir-source  = "aidanmelen/confluent-platform/kubernetes"
  version = ">= 0.6.0"
    error.path: "/tmp"
    finished.path: "/tmp"
    "halt.on.error": "false"
    schema.generation.enabled: "true"
    "topic": "spooldir-testing-topic"
  EOF
  )
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.8 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.0.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.12.1 |
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_confluent_platform"></a> [confluent\_platform](#module\_confluent\_platform) | ../../ | n/a |
| <a name="module_spooldir_source_connector"></a> [spooldir\_source\_connector](#module\_spooldir\_source\_connector) | ../../modules/connector | n/a |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_spooldir_source_connector"></a> [spooldir\_source\_connector](#output\_spooldir\_source\_connector) | The SpoolDir Source Connector object spec. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
