# schema

Deploy a Schema on the Schema Registry.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Example

```hcl
module "schema" {
  source  = "aidanmelen/confluent-platform/kubernetes//modules/schema"
  version = ">= 0.9.0"

  name      = "pageviews-value"
  namespace = var.namespace
  data      = <<-EOF
    {
      "connect.name": "ksql.pageviews",
      "fields": [
        {
          "name": "viewtime",
          "type": "long"
        },
        {
          "name": "userid",
          "type": "string"
        },
        {
          "name": "pageid",
          "type": "string"
        }
      ],
      "name": "pageviews",
      "namespace": "ksql",
      "type": "record"
    }
  EOF
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
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_schema_override_values"></a> [schema\_override\_values](#module\_schema\_override\_values) | Invicton-Labs/deepmerge/null | 0.1.5 |
## Resources

| Name | Type |
|------|------|
| [kubernetes_config_map_v1.schema_config](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map_v1) | resource |
| [kubernetes_manifest.schema](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_resource.schema](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/resource) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_timeout"></a> [create\_timeout](#input\_create\_timeout) | The create timeout for each Confluent Platform component. | `string` | `"10m"` | no |
| <a name="input_data"></a> [data](#input\_data) | The Schema config data. | `any` | n/a | yes |
| <a name="input_delete_timeout"></a> [delete\_timeout](#input\_delete\_timeout) | The delete timeout for each Confluent Platform component. | `string` | `"10m"` | no |
| <a name="input_name"></a> [name](#input\_name) | The Schema name. | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace of the Confluent Platform. | `string` | `"confluent"` | no |
| <a name="input_update_timeout"></a> [update\_timeout](#input\_update\_timeout) | The update timeout for each Confluent Platform component. | `string` | `"10m"` | no |
| <a name="input_values"></a> [values](#input\_values) | The Schema override values. | `any` | `{}` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_config_map"></a> [config\_map](#output\_config\_map) | The ConfigMap containing the Schema config data. |
| <a name="output_manifest"></a> [manifest](#output\_manifest) | The Schema manifest. |
| <a name="output_object"></a> [object](#output\_object) | The Schema object. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
