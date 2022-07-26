# terraform-kubernetes-confluent-platform/quickstart_deploy/confluent_platform

Deploy the Confluent Platform. Similiar to the [confluent-for-kubernetes-examples/quickstart-deploy/confluent-platform.yaml)](https://github.com/confluentinc/confluent-kubernetes-examples/blob/master/quickstart-deploy/confluent-platform.yaml)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Example

### Confluent Platform

```hcl
module "confluent_platform" {
  # source    = "terraform-kubernetes-confluent-platform/examples//quickstart_deploy/confluent_platform"
  source    = "../../../"
  namespace = "confluent"

  /*
  zookeeper_spec        = { ... }
  kafka_spec            = { ... }
  connect_spec          = { ... }
  ksqldb_spec           = { ... }
  control_center_spec   = { ... }
  schema_registry_spec  = { ... }
  kafka_rest_proxy_spec = { ... }
  */
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.8 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.0.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.12.1 |
## Providers

No providers.
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_confluent_platform"></a> [confluent\_platform](#module\_confluent\_platform) | ../../../ | n/a |
## Resources

No resources.
## Inputs

No inputs.
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_confluent_platform"></a> [confluent\_platform](#output\_confluent\_platform) | The confluent platform outputs. |
| <a name="output_connect"></a> [connect](#output\_connect) | The Connect CFK manifest. |
| <a name="output_control_center"></a> [control\_center](#output\_control\_center) | The ControlCenter CFK manifest. |
| <a name="output_kafka"></a> [kafka](#output\_kafka) | The Kafka CFK manifest. |
| <a name="output_kafka_rest_proxy"></a> [kafka\_rest\_proxy](#output\_kafka\_rest\_proxy) | The KafkaRestProxy CFK manifest. |
| <a name="output_ksqldb"></a> [ksqldb](#output\_ksqldb) | The KsqlDB CFK manifest. |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | The namespace for the confluent platform. |
| <a name="output_schema_registry"></a> [schema\_registry](#output\_schema\_registry) | The SchemaRegistry CFK manifest. |
| <a name="output_zookeeper"></a> [zookeeper](#output\_zookeeper) | The Zookeeper CFK manifest. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
