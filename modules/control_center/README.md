# terraform-kubernetes-confluent-platform/control_center

Confluent ControlCenter submodule.

## Example

```hcl
module "control_center" {
  source    = "aidanmelen/kubernetes/confluent-platform//modules/control_center"
  namespace = "confluent"
  spec      = {
    "dataVolumeCapacity" = "10Gi"
    "dependencies" = {
      "connect" = [
        {
          "name" = "connect"
          "url"  = "http://connect.confluent.svc.cluster.local:8083"
        },
      ]
      "ksqldb" = [
        {
          "name" = "ksqldb"
          "url"  = "http://ksqldb.confluent.svc.cluster.local:8088"
        },
      ]
      "schemaRegistry" = {
        "url" = "http://schemaregistry.confluent.svc.cluster.local:8081"
      }
    }
    "image" = {
      "application" = "confluentinc/cp-enterprise-control-center:7.2.0"
      "init"        = "confluentinc/confluent-init-container:2.4.0"
    }
    "replicas" = 1
  }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.8 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.12.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.12.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_manifest.control_center](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_metadata"></a> [additional\_metadata](#input\_additional\_metadata) | The additional kubernetes metadata for the CFK component. | `any` | `{}` | no |
| <a name="input_computed_fields"></a> [computed\_fields](#input\_computed\_fields) | The `computed_fields` block for the kubernetes\_manifest resource. | `list(string)` | <pre>[<br>  "metadata.finalizers"<br>]</pre> | no |
| <a name="input_create_timeout"></a> [create\_timeout](#input\_create\_timeout) | The create timeout. | `string` | `"20m"` | no |
| <a name="input_delete_timeout"></a> [delete\_timeout](#input\_delete\_timeout) | The delete timeout. | `string` | `"10m"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name for the CFK component. | `string` | `"controlcenter"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The kubernetes namespace for the CFK component. | `string` | `"confluent"` | no |
| <a name="input_spec"></a> [spec](#input\_spec) | The kubernetes spec for the CFK component. | `any` | <pre>{<br>  "dataVolumeCapacity": "10Gi",<br>  "dependencies": {<br>    "connect": [<br>      {<br>        "name": "connect",<br>        "url": "http://connect.confluent.svc.cluster.local:8083"<br>      }<br>    ],<br>    "ksqldb": [<br>      {<br>        "name": "ksqldb",<br>        "url": "http://ksqldb.confluent.svc.cluster.local:8088"<br>      }<br>    ],<br>    "schemaRegistry": {<br>      "url": "http://schemaregistry.confluent.svc.cluster.local:8081"<br>    }<br>  },<br>  "image": {<br>    "application": "confluentinc/cp-enterprise-control-center:7.2.0",<br>    "init": "confluentinc/confluent-init-container:2.4.0"<br>  },<br>  "replicas": 1<br>}</pre> | no |
| <a name="input_update_timeout"></a> [update\_timeout](#input\_update\_timeout) | The update timeout. | `string` | `"20m"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_component"></a> [component](#output\_component) | The component outputs. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache 2 Licensed. See [LICENSE](./LICENSE) for full details.
