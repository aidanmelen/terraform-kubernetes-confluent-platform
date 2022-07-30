# pre_existing_crds

Deploy the Confluent Operator and Confluent Platform in a single Terraform run. This Terraforms [confluent-for-kubernetes-examples/quickstart-deploy/confluent-platform.yaml](https://github.com/confluentinc/confluent-kubernetes-examples/blob/master/quickstart-deploy/confluent-platform.yaml).

## Prerequisites

The Confluent for Kubernetes CRDs must installed on the Kubernetes cluster before the first Terraform apply of the Confluent Platform. Install the CRDs with:

```bash
make install-cfk-crds
```

Please see the [Makefile](./Makefile) for more information.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Example

```hcl
module "confluent_platform" {
  source  = "aidanmelen/confluent-platform/kubernetes"
  version = ">= 0.3.0"

  namespace = var.namespace

  # confluent operator
  confluent_operator = {
    create_namespace = true
    name             = "confluent-operator"
    chart_version    = "0.517.12"
  }

  # confluent platform
  create                = true
  create_zookeeper      = true
  create_kafka          = true
  create_connect        = false
  create_ksqldb         = false
  create_controlcenter  = false
  create_schemaregistry = false
  create_kafkarestproxy = false
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
| <a name="output_kafka"></a> [kafka](#output\_kafka) | The Kafka CFK manifest. |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | The namespace for the Confluent Platform. |
| <a name="output_zookeeper"></a> [zookeeper](#output\_zookeeper) | The Zookeeper CFK manifest. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
