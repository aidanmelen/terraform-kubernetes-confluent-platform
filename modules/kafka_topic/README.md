# kafka_topic

Deploy a KafkaTopic.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Example

```hcl
module "kafka_topic" {
  source = "../../modules/kafka_topic"

  name      = "my-topic"
  namespace = "confluent"
}

module "other_kafka_topic" {
  source = "../../modules/kafka_topic"

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
## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.12.1 |
## Resources

| Name | Type |
|------|------|
| [kubernetes_manifest.topic](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_resource.topic](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/resource) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_timeout"></a> [create\_timeout](#input\_create\_timeout) | The create timeout for each Conlfuent Platform component. | `string` | `"5m"` | no |
| <a name="input_delete_timeout"></a> [delete\_timeout](#input\_delete\_timeout) | The delete timeout for each Conlfuent Platform component. | `string` | `"5m"` | no |
| <a name="input_name"></a> [name](#input\_name) | The KafkaTopic name. | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace of the Confluent Platform. | `string` | `"confluent"` | no |
| <a name="input_update_timeout"></a> [update\_timeout](#input\_update\_timeout) | The update timeout for each Conlfuent Platform component. | `string` | `"5m"` | no |
| <a name="input_values"></a> [values](#input\_values) | The KafkaTopic override values. | `any` | `{}` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_manifest"></a> [manifest](#output\_manifest) | The KafkaTopic manifest. |
| <a name="output_object"></a> [object](#output\_object) | The KafkaTopic object. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
