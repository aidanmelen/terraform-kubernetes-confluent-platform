# schema

Deploy a Schema on the Schema Registry. This example produces Avro messages to the `pageviews` topic using the [kafka-connect-datagen](https://github.com/confluentinc/kafka-connect-datagen) connector.

## Assumptions

This example assumes you have a Kubernetes cluster running locally on Docker Desktop. Please see [Docker's official documentation](https://docs.docker.com/desktop/kubernetes/) for more information.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Example

```hcl
module "schema" {
  source  = "aidanmelen/confluent-platform/kubernetes//modules/schema"
  version = ">= 0.8.0"

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
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_confluent_platform"></a> [confluent\_platform](#module\_confluent\_platform) | ../../ | n/a |
| <a name="module_schema"></a> [schema](#module\_schema) | ../../modules/schema | n/a |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_controlcenter"></a> [create\_controlcenter](#input\_create\_controlcenter) | Controls if the ControlCenter component of the Confluent Platform should be created. | `bool` | `true` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to release the Confluent Operator and Confluent Platform into. | `string` | `"confluent"` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_schema_config_map_data"></a> [schema\_config\_map\_data](#output\_schema\_config\_map\_data) | The Schema ConfigMap data. |
| <a name="output_schema_object_spec"></a> [schema\_object\_spec](#output\_schema\_object\_spec) | The Schema object spec. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
