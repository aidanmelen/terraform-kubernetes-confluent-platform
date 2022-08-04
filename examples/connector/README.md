# connector

Deploy a Connector on Kafka Connect. This example produces data to `my-topic` and uses the connector to mirror the data to `self.my-topic`

## Assumptions

This example assumes you have a Kubernetes cluster running locally on Docker Desktop. Please see [Docker's official documentation](https://docs.docker.com/desktop/kubernetes/) for more information.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Example

```hcl
module "connector" {
  source     = "aidanmelen/confluent-platform/kubernetes//modules/connector"
  version    = ">= 0.7.0"
  depends_on = [module.confluent_platform]

  name      = "my-connector"
  namespace = var.namespace
  values = yamldecode(<<-EOF
    spec:
      class: "org.apache.kafka.connect.mirror.MirrorSourceConnector"
      taskMax: 1
      configs:
        topics: "my-topic"
        target.cluster.bootstrap.servers: "kafka:9092"
        source.cluster.bootstrap.servers: "kafka:9092"
        source.cluster.alias: "self"
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
| <a name="module_connector"></a> [connector](#module\_connector) | ../../modules/connector | n/a |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_controlcenter"></a> [create\_controlcenter](#input\_create\_controlcenter) | Controls if the ControlCenter component of the Confluent Platform should be created. | `bool` | `true` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to release the Confluent Operator and Confluent Platform into. | `string` | `"confluent"` | no |
| <a name="input_producer_num_records"></a> [producer\_num\_records](#input\_producer\_num\_records) | The number of messages to produce to `my-topic`. | `number` | `1000` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connector"></a> [connector](#output\_connector) | The Connector object spec. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
