[![Pre-Commit](https://github.com/aidanmelen/terraform-kubernetes-confluent-platform/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/aidanmelen/terraform-kubernetes-confluent-platform/actions/workflows/pre-commit.yaml)
[![cookiecutter-tf-module](https://img.shields.io/badge/cookiecutter--tf--module-enabled-brightgreen)](https://github.com/aidanmelen/cookiecutter-tf-module)

# terraform-kubernetes-confluent-platform

A Terraform module for managing [Confluent for Kubernetes (CFK)](https://docs.confluent.io/operator/current/overview.html).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## Prerequisites

The Confluent for Kubernetes CRDs must be installed on the Kubernetes cluster before the first Terraform apply of the Confluent Platform. Install the CRDs with:

```bash
kubectl config set-cluster docker-desktop
kubectl apply -f ./crds/2.4.0
```

Please see [The Confluent for Kubernetes Quickstart](https://docs.confluent.io/operator/current/co-quickstart.html#step-2-install-co-long) for more information.

## Override CFK Manifest Values

Similar to the [values file for Helm](https://helm.sh/docs/chart_template_guide/values_files/); the Confluent Platform variables will be [deep-merged](https://github.com/privx-de/terraform-deepmerge) with the default `local` values of the module. Please see the [Confluent Platform Single Node](./examples/confluent_platform_singlenode) example for more information.

## Example

### Confluent Platform

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

  create_connect        = false
  create_ksqldb         = false
  create_controlcenter  = false
  create_schemaregistry = false
  create_kafkarestproxy = false

  kafka_topics = {
    "my-topic"       = {}
    "my-other-topic" = { "spec" = { "configs" = { "cleanup.policy" = "compact" } } }
  }
}
```

## Usage

Release the Confluent Platform with:

```bash
cd examples/complete
terraform init
terraform apply
```

### Troubleshooting

```
Error: Failed to determine GroupVersionResource for manifest
```

This happens when you attempt to apply the Confluent Platform Terraform without first creating the Confluent for Kubernetes CRDs. Please see [Prerequisites](#prerequisites) for more information.

## Tests

Run Terratest using the [Makefile](./Makefile) targets:

1. `make setup`
2. `make tests`

## Makefile Targets

```
help                                This help.
build                               Build docker dev container
run                                 Run docker dev container
setup                               Setup project
lint                                Lint with pre-commit
lint-all                            Lint all files with pre-commit
tests                               Tests with Terratest
test-confluent-operator             Test the confluent_operator example
test-confluent-platform             Test the confluent_platform example
test-confluent-platform-singlenode  Test the confluent_platform_singlenode example
test-complete                       Test the complete example
test-kafka-topics                   Test the kafka_topics example
clean                               Clean project
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.8 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.0.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.12.1 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.12.1 |
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_confluent_operator"></a> [confluent\_operator](#module\_confluent\_operator) | ./modules/confluent_operator | n/a |
| <a name="module_confluent_platform_override_values"></a> [confluent\_platform\_override\_values](#module\_confluent\_platform\_override\_values) | Invicton-Labs/deepmerge/null | 0.1.5 |
| <a name="module_kafka_topics"></a> [kafka\_topics](#module\_kafka\_topics) | ./modules/kafka_topic | n/a |
## Resources

| Name | Type |
|------|------|
| [kubernetes_manifest.components](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_resource.components](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/resource) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_confluent_operator"></a> [confluent\_operator](#input\_confluent\_operator) | Controls if the Confluent Operator resources should be created. This is required when the Confluent Operator is not already running on the kubernetes cluster. | `any` | `{}` | no |
| <a name="input_confluent_operator_app_version"></a> [confluent\_operator\_app\_version](#input\_confluent\_operator\_app\_version) | The default Confluent Operator app version. This may be overriden by component override values. This version must be compatible with the `confluent_platform_version`. Please see confluent docs for more information: https://docs.confluent.io/platform/current/installation/versions-interoperability.html#confluent-operator | `string` | `"2.4.0"` | no |
| <a name="input_confluent_platform_version"></a> [confluent\_platform\_version](#input\_confluent\_platform\_version) | The default Confluent Platform app version. This may be overriden by component override values. This version must be compatible with the `confluent_operator_app_version`. Please see confluent docs for more information: https://docs.confluent.io/platform/current/installation/versions-interoperability.html#confluent-operator | `string` | `"7.2.0"` | no |
| <a name="input_connect"></a> [connect](#input\_connect) | The Connect override values. | `any` | `{}` | no |
| <a name="input_controlcenter"></a> [controlcenter](#input\_controlcenter) | The ControlCenter override values. | `any` | `{}` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls if the Confluent Platform and Operator resources should be created (affects all resources). | `bool` | `true` | no |
| <a name="input_create_connect"></a> [create\_connect](#input\_create\_connect) | Controls if the Connect component of the Confluent Platform should be created. | `bool` | `true` | no |
| <a name="input_create_controlcenter"></a> [create\_controlcenter](#input\_create\_controlcenter) | Controls if the ControlCenter component of the Confluent Platform should be created. | `bool` | `true` | no |
| <a name="input_create_kafka"></a> [create\_kafka](#input\_create\_kafka) | Controls if the Kafka component of the Confluent Platform should be created. | `bool` | `true` | no |
| <a name="input_create_kafkarestproxy"></a> [create\_kafkarestproxy](#input\_create\_kafkarestproxy) | Controls if the KafkaRestProxy component of the Confluent Platform should be created. | `bool` | `true` | no |
| <a name="input_create_ksqldb"></a> [create\_ksqldb](#input\_create\_ksqldb) | Controls if the KsqlDB component of the Confluent Platform should be created. | `bool` | `true` | no |
| <a name="input_create_schemaregistry"></a> [create\_schemaregistry](#input\_create\_schemaregistry) | Controls if the SchemaRegistry component of the Confluent Platform should be created. | `bool` | `true` | no |
| <a name="input_create_timeout"></a> [create\_timeout](#input\_create\_timeout) | The create timeout for each Confluent Platform component. | `string` | `"1h"` | no |
| <a name="input_create_zookeeper"></a> [create\_zookeeper](#input\_create\_zookeeper) | Controls if the Zookeeper component of the Confluent Platform should be created. | `bool` | `true` | no |
| <a name="input_delete_timeout"></a> [delete\_timeout](#input\_delete\_timeout) | The delete timeout for each Confluent Platform component. | `string` | `"10m"` | no |
| <a name="input_kafka"></a> [kafka](#input\_kafka) | The Kafka override values. | `any` | `{}` | no |
| <a name="input_kafka_topics"></a> [kafka\_topics](#input\_kafka\_topics) | A map of Kafka Topics to create. | `any` | `{}` | no |
| <a name="input_kafkarestproxy"></a> [kafkarestproxy](#input\_kafkarestproxy) | The KafkaRestProxy override values. | `any` | `{}` | no |
| <a name="input_ksqldb"></a> [ksqldb](#input\_ksqldb) | The KsqlDB override values. | `any` | `{}` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to release Confluent Platform into. When `confluent_operator` is specified, this will also ensure the Confluent Operator is released into the same namespace. | `string` | `"confluent"` | no |
| <a name="input_schemaregistry"></a> [schemaregistry](#input\_schemaregistry) | The SchemaRegistry override values. | `any` | `{}` | no |
| <a name="input_update_timeout"></a> [update\_timeout](#input\_update\_timeout) | The update timeout for each Confluent Platform component. | `string` | `"1h"` | no |
| <a name="input_zookeeper"></a> [zookeeper](#input\_zookeeper) | The Zookeeper override values. | `any` | `{}` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_confluent_operator"></a> [confluent\_operator](#output\_confluent\_operator) | Map of attributes for the Confluent Operator. |
| <a name="output_connect_manifest"></a> [connect\_manifest](#output\_connect\_manifest) | The Connect manifest. |
| <a name="output_connect_object"></a> [connect\_object](#output\_connect\_object) | The Connect object. |
| <a name="output_controlcenter_manifest"></a> [controlcenter\_manifest](#output\_controlcenter\_manifest) | The ControlCenter manifest. |
| <a name="output_controlcenter_object"></a> [controlcenter\_object](#output\_controlcenter\_object) | The ControlCenter object. |
| <a name="output_kafka_manifest"></a> [kafka\_manifest](#output\_kafka\_manifest) | The Kafka manifest. |
| <a name="output_kafka_object"></a> [kafka\_object](#output\_kafka\_object) | The Kafka object. |
| <a name="output_kafka_topic_manifests"></a> [kafka\_topic\_manifests](#output\_kafka\_topic\_manifests) | Map of attribute maps for all the KafkaTopic manifests created. |
| <a name="output_kafka_topic_objects"></a> [kafka\_topic\_objects](#output\_kafka\_topic\_objects) | Map of attribute maps for all the KafkaTopic objects created. |
| <a name="output_kafka_topics"></a> [kafka\_topics](#output\_kafka\_topics) | Map of attribute maps for all KafkaTopic submodules created. |
| <a name="output_kafkarestproxy_manifest"></a> [kafkarestproxy\_manifest](#output\_kafkarestproxy\_manifest) | The KafkaRestProxy manifest. |
| <a name="output_kafkarestproxy_object"></a> [kafkarestproxy\_object](#output\_kafkarestproxy\_object) | The KafkaRestProxy object. |
| <a name="output_ksqldb_manifest"></a> [ksqldb\_manifest](#output\_ksqldb\_manifest) | The KsqlDB manifest. |
| <a name="output_ksqldb_object"></a> [ksqldb\_object](#output\_ksqldb\_object) | The KsqlDB object. |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | The default namespace for the Confluent Platform. |
| <a name="output_schemaregistry_manifest"></a> [schemaregistry\_manifest](#output\_schemaregistry\_manifest) | The SchemaRegistry manifest. |
| <a name="output_schemaregistry_object"></a> [schemaregistry\_object](#output\_schemaregistry\_object) | The SchemaRegistry object. |
| <a name="output_zookeeper_manifest"></a> [zookeeper\_manifest](#output\_zookeeper\_manifest) | The Zookeeper manifest. |
| <a name="output_zookeeper_object"></a> [zookeeper\_object](#output\_zookeeper\_object) | The Zookeeper object. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache 2 Licensed. See [LICENSE](https://github.com/aidanmelen/terraform-kubernetes-confluent-platform/blob/main/LICENSE) for full details.
