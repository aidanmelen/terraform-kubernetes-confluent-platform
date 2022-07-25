# terraform-confluent-for-kubernetes/confluent_operator

Deploy the Confluent Operator.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Example

### Confluent Operator

```hcl
# terraform_confluent_for_kubernetes/examples/confluent_operator/main.tf
module "confluent_operator" {
  source           = "../../modules/confluent_operator"
  name             = "confluent-operator"
  namespace        = "confluent"
  create_namespace = true
  chart_version    = "0.517.12"
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.8 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.0.0 |
## Providers

No providers.
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_confluent_operator"></a> [confluent\_operator](#module\_confluent\_operator) | ../../modules/confluent_operator | n/a |
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
| <a name="output_latest_confluent_platform_version_compatibilities"></a> [latest\_confluent\_platform\_version\_compatibilities](#output\_latest\_confluent\_platform\_version\_compatibilities) | The latest version compatibile among Confluent Platform and Confluent for Kubernetes (CFK). |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
