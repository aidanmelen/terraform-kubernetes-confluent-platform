# complete

Deploy the Confluent Operator and Confluent Platform in a single Terraform run.

## Assumptions

This example assumes you have a Kubernetes cluster running locally on Docker Desktop. Please see [Docker's official documentation](https://docs.docker.com/desktop/kubernetes/) for more information.

## Prerequisites

The Confluent for Kubernetes CRDs must installed on the Kubernetes cluster before the first Terraform apply of the Confluent Platform. Install the CRDs with:

```bash
kubectl config set-cluster docker-desktop
kubectl apply -f ./crds/2.4.0
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Example

```hcl
module "confluent_platform" {
  source  = "aidanmelen/confluent-platform/kubernetes"
  version = ">= 0.9.0"

  namespace = var.namespace

  confluent_operator = {
    create_namespace = true
    name             = "confluent-operator"
    chart_version    = "0.517.12"
  }

  # value overrides
  zookeeper = {
    "spec" = {
      "replicas" = "3"
    }
  }

  # yaml inline value overrides
  kafka = yamldecode(<<-EOF
    spec:
      replicas: 3
    EOF
  )

  # yaml file value overrides
  connect = yamldecode(file("${path.module}/values/connect.yaml"))

  create_ksqldb         = false
  create_controlcenter  = var.create_controlcenter
  create_schemaregistry = true # explictly create with default values
  create_kafkarestproxy = false

  kafka_topics = {
    "pageviews" = {}
    "my-other-topic" = {
      "values" = { "spec" = { "configs" = { "cleanup.policy" = "compact" } } }
    }
  }

  schemas = {
    "pageviews-value" = {
      "data" = file("${path.module}/schemas/pageviews.avro")
    }
  }

  connectors = {
    "pageviews-source" = {
      "values" = yamldecode(
        templatefile(
          "${path.module}/values/connector.yaml",
          {
            "datagen_source_connector_max_interval" : var.datagen_source_connector_max_interval,
            "datagen_source_connector_iterations" : var.datagen_source_connector_iterations
          }
        )
      )
    }
  }
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
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_controlcenter"></a> [create\_controlcenter](#input\_create\_controlcenter) | Controls if the ControlCenter component of the Confluent Platform should be created. | `bool` | `true` | no |
| <a name="input_datagen_source_connector_iterations"></a> [datagen\_source\_connector\_iterations](#input\_datagen\_source\_connector\_iterations) | Number of messages to send from each task, or -1 for unlimited | `number` | `-1` | no |
| <a name="input_datagen_source_connector_max_interval"></a> [datagen\_source\_connector\_max\_interval](#input\_datagen\_source\_connector\_max\_interval) | Max interval between messages (ms) | `number` | `500` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to release the Confluent Operator and Confluent Platform into. | `string` | `"confluent"` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_confluent_operator"></a> [confluent\_operator](#output\_confluent\_operator) | The Confluent Operator. |
| <a name="output_connect_manifest"></a> [connect\_manifest](#output\_connect\_manifest) | The Connect manifest. |
| <a name="output_connect_object_spec"></a> [connect\_object\_spec](#output\_connect\_object\_spec) | The Connect object spec. |
| <a name="output_connector_manifests"></a> [connector\_manifests](#output\_connector\_manifests) | Map of attribute maps for all the Connector manifests created. |
| <a name="output_connector_object_specs"></a> [connector\_object\_specs](#output\_connector\_object\_specs) | Map of attribute maps for all the Connector object specs created. |
| <a name="output_kafka_manifest"></a> [kafka\_manifest](#output\_kafka\_manifest) | The Kafka manifest. |
| <a name="output_kafka_object_spec"></a> [kafka\_object\_spec](#output\_kafka\_object\_spec) | The Kafka object spec. |
| <a name="output_kafka_topic_manifests"></a> [kafka\_topic\_manifests](#output\_kafka\_topic\_manifests) | Map of attribute maps for all the KafkaTopic manifests created. |
| <a name="output_kafka_topic_object_specs"></a> [kafka\_topic\_object\_specs](#output\_kafka\_topic\_object\_specs) | Map of attribute maps for all the KafkaTopic object specs created. |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | The namespace for the Confluent Platform. |
| <a name="output_schema_config_map_data"></a> [schema\_config\_map\_data](#output\_schema\_config\_map\_data) | Map of attribute maps for all the Schema config data created. |
| <a name="output_schema_manifests"></a> [schema\_manifests](#output\_schema\_manifests) | Map of attribute maps for all the Schema manifests created. |
| <a name="output_schema_object_specs"></a> [schema\_object\_specs](#output\_schema\_object\_specs) | Map of attribute maps for all the Schema object specs created. |
| <a name="output_zookeeper_manifest"></a> [zookeeper\_manifest](#output\_zookeeper\_manifest) | The Zookeeper manifest. |
| <a name="output_zookeeper_object_spec"></a> [zookeeper\_object\_spec](#output\_zookeeper\_object\_spec) | The Zookeeper object spec. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
