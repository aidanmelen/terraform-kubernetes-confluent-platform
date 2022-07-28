# confluent_operator

Deploy the Confluent Operator.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Example

```hcl
# https://github.com/aidanmelen/terraform-kubernetes-confluent-platform/tree/main/examples/confluent_operator
module "confluent_operator" {
  source = "../../modules/confluent_operator"

  create_namespace = true
  namespace        = "confluent"
  name             = "confluent-operator"
  chart_version    = "0.517.12"
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
| <a name="module_confluent_operator"></a> [confluent\_operator](#module\_confluent\_operator) | ../../modules/confluent_operator | n/a |
## Resources

No resources.
## Inputs

No inputs.
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_confluent_operator"></a> [confluent\_operator](#output\_confluent\_operator) | The Confluent Operator outputs. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
