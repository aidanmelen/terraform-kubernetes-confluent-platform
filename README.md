[![Pre-Commit](https://github.com/aidanmelen/terraform-kubernetes-confluent-platform/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/aidanmelen/terraform-kubernetes-confluent-platform/actions/workflows/pre-commit.yaml)
[![cookiecutter-tf-module](https://img.shields.io/badge/cookiecutter--tf--module-enabled-brightgreen)](https://github.com/aidanmelen/cookiecutter-tf-module)

# terraform-kubernetes-confluent-platform

A Terraform module for running [Confluent for Kubernetes (CFK)](https://docs.confluent.io/operator/current/overview.html).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## Example

### Confluent Operator

```hcl
module "confluent_operator" {
  source  = "aidanmelen/confluent-platform/kubernetes//modules/confluent_operator"
  version = ">= 0.3.0"

  create_namespace = true
  namespace        = "confluent"
  name             = "confluent-operator"
  chart_version    = "0.517.12"
}
```

### Confluent Platform

```hcl
module "confluent_platform" {
  source    = "aidanmelen/confluent-platform/kubernetes"
  version   = ">= 0.3.0"
  namespace = "confluent"

  /*
  zookeeper      = { ... }
  kafka          = { ... }
  connect        = { ... }
  ksqldb         = { ... }
  controlcenter  = { ... }
  schemaregistry = { ... }
  kafkarestproxy = { ... }
  */
}
```

## Usage

Similiar to the [Deploy Applications with the Helm Provider](https://learn.hashicorp.com/tutorials/terraform/helm-provider?in=terraform/use-case) tutorial; releasing the Confluent Operator and Confluent Platform will require two separate Terraform runs. For example:

### Confluent Operator

First, create the `confluent` namespace and release Confluent Operator into it:

```bash
cd examples/confluent_operator
terraform init
terraform apply
```

Please see the [Confluent for Kubernetes Quickstart](https://docs.confluent.io/operator/current/co-quickstart.html#co-long-quickstart) for more information releasing the Confluent Operator.

### Confluent Platform

Second, apply the Confluent Platform:

```bash
cd examples/confluent_platform
terraform init
terraform apply
```

## Teardown

1. Destroy the Confluent Platform:

```bash
cd examples/confluent_platform
terraform destroy
```

2. Uninstall the Confluent Operator and delete `confluent` namespace:

```bash
cd examples/confluent_operator
terraform destroy
```

## Tests

Run Terratest using the [Makefile](./Makefile) targets:

1. `make install`
2. `make tests`

## Makefile Targets

```
help                      This help.
build                     Build docker dev container
run                       Run docker dev container
install                   Install project
lint                      Lint with pre-commit
lint-all                  Lint with pre-commit
tests                     Test with Terratest
test-confluent-operator   Test confluent-operator Example
test-confluent-platform   Test confluent-platform Example
clean                     Clean project
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
| <a name="module_connect"></a> [connect](#module\_connect) | Invicton-Labs/deepmerge/null | 0.1.5 |
| <a name="module_controlcenter"></a> [controlcenter](#module\_controlcenter) | Invicton-Labs/deepmerge/null | 0.1.5 |
| <a name="module_kafka"></a> [kafka](#module\_kafka) | Invicton-Labs/deepmerge/null | 0.1.5 |
| <a name="module_kafkarestproxy"></a> [kafkarestproxy](#module\_kafkarestproxy) | Invicton-Labs/deepmerge/null | 0.1.5 |
| <a name="module_ksqldb"></a> [ksqldb](#module\_ksqldb) | Invicton-Labs/deepmerge/null | 0.1.5 |
| <a name="module_schemaregistry"></a> [schemaregistry](#module\_schemaregistry) | Invicton-Labs/deepmerge/null | 0.1.5 |
| <a name="module_zookeeper"></a> [zookeeper](#module\_zookeeper) | Invicton-Labs/deepmerge/null | 0.1.5 |
## Resources

| Name | Type |
|------|------|
| [kubernetes_manifest.connect](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.controlcenter](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.kafka](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.kafkarestproxy](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.ksqldb](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.schemaregistry](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.zookeeper](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_confluent_operator_app_version"></a> [confluent\_operator\_app\_version](#input\_confluent\_operator\_app\_version) | The default Confluent Operator app version. This version may be overriden by component override values. This version must be compatible with the confluent operator app version. For more information, please visit: https://docs.confluent.io/platform/current/installation/versions-interoperability.html#confluent-operator | `string` | `"2.4.0"` | no |
| <a name="input_confluent_platform_version"></a> [confluent\_platform\_version](#input\_confluent\_platform\_version) | The default Confluent Platform app version. This version may be overriden by component override values. This version must be compatible with the confluent operator app version. For more information, please visit: https://docs.confluent.io/platform/current/installation/versions-interoperability.html#confluent-operator | `string` | `"7.2.0"` | no |
| <a name="input_connect"></a> [connect](#input\_connect) | The Connect override values. | `any` | `null` | no |
| <a name="input_controlcenter"></a> [controlcenter](#input\_controlcenter) | The ControlCenter override values. | `any` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls if the Confluent Platform resources should be created (affects all resources). | `bool` | `true` | no |
| <a name="input_create_connect"></a> [create\_connect](#input\_create\_connect) | Whether to create the Connect component of the Confluent Platform. | `bool` | `true` | no |
| <a name="input_create_controlcenter"></a> [create\_controlcenter](#input\_create\_controlcenter) | Whether to create the ControlCenter component of the Confluent Platform. | `bool` | `true` | no |
| <a name="input_create_kafka"></a> [create\_kafka](#input\_create\_kafka) | Whether to create the Kafka component of the Confluent Platform. | `bool` | `true` | no |
| <a name="input_create_kafkarestproxy"></a> [create\_kafkarestproxy](#input\_create\_kafkarestproxy) | Whether to create the KafkaRestProxy component of the Confluent Platform. | `bool` | `true` | no |
| <a name="input_create_ksqldb"></a> [create\_ksqldb](#input\_create\_ksqldb) | Whether to create the KsqlDB component of the Confluent Platform. | `bool` | `true` | no |
| <a name="input_create_schemaregistry"></a> [create\_schemaregistry](#input\_create\_schemaregistry) | Whether to create the SchemaRegistry component of the Confluent Platform. | `bool` | `true` | no |
| <a name="input_create_zookeeper"></a> [create\_zookeeper](#input\_create\_zookeeper) | Whether to create the Zookeeper component of the Confluent Platform. | `bool` | `true` | no |
| <a name="input_kafka"></a> [kafka](#input\_kafka) | The Kafka override values. | `any` | `null` | no |
| <a name="input_kafkarestproxy"></a> [kafkarestproxy](#input\_kafkarestproxy) | The KafkaRestProxy override values. | `any` | `null` | no |
| <a name="input_ksqldb"></a> [ksqldb](#input\_ksqldb) | The KsqlDB override values. | `any` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to release Confluent Platform into. Must be the same namespace running the Confluent Operator. | `string` | `"confluent"` | no |
| <a name="input_schemaregistry"></a> [schemaregistry](#input\_schemaregistry) | The SchemaRegistry override values. | `any` | `null` | no |
| <a name="input_zookeeper"></a> [zookeeper](#input\_zookeeper) | The Zookeeper override values. | `any` | `null` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_confluent_platform_version"></a> [confluent\_platform\_version](#output\_confluent\_platform\_version) | The default Confluent Platform version. |
| <a name="output_connect_manifest"></a> [connect\_manifest](#output\_connect\_manifest) | The Connect manifest. |
| <a name="output_controlcenter_manifest"></a> [controlcenter\_manifest](#output\_controlcenter\_manifest) | The ControlCenter manifest. |
| <a name="output_kafka_manifest"></a> [kafka\_manifest](#output\_kafka\_manifest) | The Kafka manifest. |
| <a name="output_kafkarestproxy_manifest"></a> [kafkarestproxy\_manifest](#output\_kafkarestproxy\_manifest) | The KafkaRestProxy manifest. |
| <a name="output_ksqldb_manifest"></a> [ksqldb\_manifest](#output\_ksqldb\_manifest) | The KsqlDB manifest. |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | The default namespace for the Confluent Platform. |
| <a name="output_schemaregistry_manifest"></a> [schemaregistry\_manifest](#output\_schemaregistry\_manifest) | The SchemaRegistry manifest. |
| <a name="output_zookeeper_manifest"></a> [zookeeper\_manifest](#output\_zookeeper\_manifest) | The Zookeeper manifest. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache 2 Licensed. See [LICENSE](https://github.com/aidanmelen/terraform-kubernetes-confluent-platform/blob/main/LICENSE) for full details.
