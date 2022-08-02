# connectors

Deploy a Connector on Kafka Connect.

## Prerequisites

Kafka Connect must be running before the Connector instance is created. Please see the [connectors example](../../examples/connectors) for more information.


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Example

```hcl
module "confluent_platform" {
  source = "../confluent_platform_singlenode"
}

module "file_stream_source_connector" {
  source = "../../modules/connector"

  name      = "my-file-stream-source-connector"
  namespace = "confluent"
  class     = "FileStreamSource"

  config = {
    "tasks.max" : "1"
    "file" : "/tmp/test.txt"
    "topic" : "connect-test"
  }
}

# module "file_stream_sink_connector" {
#   source = "../../modules/connector"

#   name      = "my-file-stream-sink-connector"
#   namespace = "confluent"

#   values = yamldecode(<<EOF
# spec:
#   class: "FileStreamSink"
#   taskMax: 3
#   connectClusterRef:
#     name: connect
#   configs:
#     tasks.max: "1"
#     file: "/tmp/test.txt"
#     topic: "connect-test"
#   EOF
#   )
# }
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
| <a name="module_connector_override_values"></a> [connector\_override\_values](#module\_connector\_override\_values) | Invicton-Labs/deepmerge/null | 0.1.5 |
## Resources

| Name | Type |
|------|------|
| [kubernetes_manifest.connector](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_resource.connector](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/resource) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_class"></a> [class](#input\_class) | class specifies the class name of the connector. The Connect cluster displays the supported class names in its status. Required when not overriden by `values`. | `string` | `""` | no |
| <a name="input_config"></a> [config](#input\_config) | configs is a map of string key and value pairs. It specifies the additional configurations for the connector. Required when not overriden by `values`. | `any` | `{}` | no |
| <a name="input_create_timeout"></a> [create\_timeout](#input\_create\_timeout) | The create timeout for each Confluent Platform component. | `string` | `"5m"` | no |
| <a name="input_delete_timeout"></a> [delete\_timeout](#input\_delete\_timeout) | The delete timeout for each Confluent Platform component. | `string` | `"5m"` | no |
| <a name="input_name"></a> [name](#input\_name) | The Connector name. | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace of the Confluent Platform. | `string` | `"confluent"` | no |
| <a name="input_update_timeout"></a> [update\_timeout](#input\_update\_timeout) | The update timeout for each Confluent Platform component. | `string` | `"5m"` | no |
| <a name="input_values"></a> [values](#input\_values) | The Connector override values. | `any` | `{}` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_manifest"></a> [manifest](#output\_manifest) | The Connector manifest. |
| <a name="output_object"></a> [object](#output\_object) | The Connector object. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
