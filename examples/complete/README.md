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

Please see the [Makefile](https://github.com/aidanmelen/terraform-kubernetes-confluent-platform/blob/main/Makefile) for more information.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Example

```hcl
module "confluent_platform" {
  source  = "aidanmelen/confluent-platform/kubernetes"
  version = ">= 0.4.0"

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
| <a name="output_kafka"></a> [kafka](#output\_kafka) | The Kafka object spec. |
| <a name="output_kafka_topics"></a> [kafka\_topics](#output\_kafka\_topics) | The Kafka Topic object specs. |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | The namespace for the Confluent Platform. |
| <a name="output_zookeeper"></a> [zookeeper](#output\_zookeeper) | The Zookeeper object spec. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
