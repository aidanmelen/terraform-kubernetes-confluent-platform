# kafka_topic

Create the Confluent Platform and then use the submodule to create Kafka topics.

## Assumptions

This example assumes you have a Kubernetes cluster running locally on Docker Desktop. Please see [Docker's official documentation](https://docs.docker.com/desktop/kubernetes/) for more information.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Example

```hcl
module "kafka_topic" {
  source     = "aidanmelen/confluent-platform/kubernetes//modules/kafka_topic"
  version    = ">= 0.7.0"
  depends_on = [module.confluent_platform]

  name      = "my-topic"
  namespace = var.namespace
}

module "other_kafka_topic" {
  source     = "aidanmelen/confluent-platform/kubernetes//modules/kafka_topic"
  version    = ">= 0.7.0"
  depends_on = [module.confluent_platform]

  name      = "my-other-topic"
  namespace = var.namespace
  values = yamldecode(<<EOF
spec:
  partitionCount: 4
  configs:
    cleanup.policy: "compact"
  kafkaRest:
    endpoint: http://kafka.confluent.svc.cluster.local:8090
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
| <a name="module_kafka_topic"></a> [kafka\_topic](#module\_kafka\_topic) | ../../modules/kafka_topic | n/a |
| <a name="module_other_kafka_topic"></a> [other\_kafka\_topic](#module\_other\_kafka\_topic) | ../../modules/kafka_topic | n/a |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to release the Confluent Operator and Confluent Platform into. | `string` | `"confluent"` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kafka_topic"></a> [kafka\_topic](#output\_kafka\_topic) | The KafkaTopic object spec. |
| <a name="output_other_kafka_topic"></a> [other\_kafka\_topic](#output\_other\_kafka\_topic) | The other KafkaTopic object spec. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
