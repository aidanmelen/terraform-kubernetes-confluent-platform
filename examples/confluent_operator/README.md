# confluent_operator

Deploy the Confluent Operator.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Example

### Confluent Operator

```hcl
# https://github.com/aidanmelen/terraform-kubernetes-confluent-platform/tree/main/examples/confluent_operator
module "confluent_operator" {
  source = "../../"


  # confluent for kubernetes helm chart
  create_namespace                 = true
  namespace                        = "confluent"
  create_confluent_operator        = true
  confluent_operator_name          = "confluent-operator"
  confluent_operator_chart_version = "0.517.12"

  # disable confluent platform components
  create_zookeeper      = false
  create_kafka          = false
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
## Providers

No providers.
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_confluent_operator"></a> [confluent\_operator](#module\_confluent\_operator) | ../../ | n/a |
## Resources

No resources.
## Inputs

No inputs.
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_version"></a> [app\_version](#output\_app\_version) | The CFK version. |
| <a name="output_chart_version"></a> [chart\_version](#output\_chart\_version) | The CFK version. |
| <a name="output_confluent_platform_version_compatibilities"></a> [confluent\_platform\_version\_compatibilities](#output\_confluent\_platform\_version\_compatibilities) | The version compatibilities among Confluent Platform and Confluent for Kubernetes (CFK). |
| <a name="output_latest_confluent_platform_version_compatibility"></a> [latest\_confluent\_platform\_version\_compatibility](#output\_latest\_confluent\_platform\_version\_compatibility) | The latest version compatibile among Confluent Platform and Confluent for Kubernetes (CFK). |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
