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
  version = ">= 0.6.0"

  namespace = var.namespace

  confluent_operator = {
    create_namespace = true
    name             = "confluent-operator"
    chart_version    = "0.517.12"
  }

  zookeeper = { "spec" = { "replicas" = "3" } } # override default value
  kafka     = { "spec" = { "replicas" = "3" } } # override default value

  create_connect        = true # create with default values
  create_ksqldb         = false
  create_controlcenter  = var.create_controlcenter
  create_schemaregistry = false
  create_kafkarestproxy = false

  kafka_topics = {
    "my-topic" = {}
    "my-other-topic" = {
      "values" = { "spec" = { "configs" = { "cleanup.policy" = "compact" } } }
    }
  }

  connectors = {
    "my-connector" = {
      "values" = yamldecode(file("${path.module}/values/connector.yaml"))
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
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_confluent_operator"></a> [confluent\_operator](#output\_confluent\_operator) | The Confluent Operator. |
| <a name="output_connector_manifests"></a> [connector\_manifests](#output\_connector\_manifests) | Map of attribute maps for all the Connector manifests created. |
| <a name="output_connector_object_specs"></a> [connector\_object\_specs](#output\_connector\_object\_specs) | Map of attribute maps for all the Connector object specs created. |
| <a name="output_kafka_manifest"></a> [kafka\_manifest](#output\_kafka\_manifest) | The Kafka manifest. |
| <a name="output_kafka_object_spec"></a> [kafka\_object\_spec](#output\_kafka\_object\_spec) | The Kafka object spec. |
| <a name="output_kafka_topic_manifests"></a> [kafka\_topic\_manifests](#output\_kafka\_topic\_manifests) | Map of attribute maps for all the KafkaTopic manifests created. |
| <a name="output_kafka_topic_object_specs"></a> [kafka\_topic\_object\_specs](#output\_kafka\_topic\_object\_specs) | Map of attribute maps for all the KafkaTopic object specs created. |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | The namespace for the Confluent Platform. |
| <a name="output_zookeeper_manifest"></a> [zookeeper\_manifest](#output\_zookeeper\_manifest) | The Zookeeper manifest. |
| <a name="output_zookeeper_object_spec"></a> [zookeeper\_object\_spec](#output\_zookeeper\_object\_spec) | The Zookeeper object spec. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
