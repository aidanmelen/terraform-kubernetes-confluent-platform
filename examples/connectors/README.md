# kafka_topic

Create a Kafka topic.

## Assumptions

This example assumes you have a Kubernetes cluster running locally on Docker Desktop. Please see [Docker's official documentation](https://docs.docker.com/desktop/kubernetes/) for more information.

## Prerequisites

Release the [Complete example](https://github.com/aidanmelen/terraform-kubernetes-confluent-platform/tree/main/examples/complete). This will ensure the CFK CRDs are created and the Confluent Operator pod is running, and the Confluent Platform created.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Example

```hcl
module "kafka_topic" {
  source  = "aidanmelen/confluent-platform/kubernetes"
  version = ">= 0.6.0"

  name      = "my-topic"
  namespace = "confluent"
}

module "other_kafka_topic" {
  source  = "aidanmelen/confluent-platform/kubernetes"
  version = ">= 0.6.0"

  name      = "my-other-topic"
  namespace = "confluent"

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
| <a name="module_confluent_platform"></a> [confluent\_platform](#module\_confluent\_platform) | ../confluent_platform_singlenode | n/a |
| <a name="module_file_stream_source_connector"></a> [file\_stream\_source\_connector](#module\_file\_stream\_source\_connector) | ../../modules/connector | n/a |
## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
