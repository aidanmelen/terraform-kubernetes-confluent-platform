[![Pre-Commit](https://github.com/aidanmelen/terraform-kubernetes-confluent-platform/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/aidanmelen/terraform-kubernetes-confluent-platform/actions/workflows/pre-commit.yaml)
[![cookiecutter-tf-module](https://img.shields.io/badge/cookiecutter--tf--module-enabled-brightgreen)](https://github.com/aidanmelen/cookiecutter-tf-module)

# terraform-kubernetes-confluent-platform

A Terraform workspace for running [Confluent for Kubernetes (CFK)](https://docs.confluent.io/operator/current/overview.html).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## Example

### Confluent Operator

```hcl
module "confluent_operator" {
  # source    = "terraform-kubernetes-confluent-platform/examples//confluent_operator"
  source           = "../../modules/confluent_operator"
  name             = "confluent-operator"
  namespace        = "confluent"
  create_namespace = true
  chart_version    = "0.517.12"
}
```

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

## Usage

The Confluent for Kubernetes (CFK) Custom Resource Definitions (CRDs) must be released on the kubernetes cluster before the `terraform-kubernetes-confluent-platform` module is run. The CFK CRDs can be released manually sing the `helm` commandline tool.

```
helm repo add confluentinc https://packages.confluent.io/helm
helm repo update
```

---

Otherwise, the Confluent Operator and Confluent Platform can be deployed using Terraform. This deployment will require two separate Terraform workspace runs similiar to the [Deploy Applications with the Helm Provider](https://learn.hashicorp.com/tutorials/terraform/helm-provider?in=terraform/use-case) tutorial. For example:

1. Apply the `confluent` namespace and release Confluent Operator into it:

```bash
cd examples/confluent_operator
terraform init
terraform apply
```

2. Apply the Confluent Platform:

```bash
cd examples/quickstart_deploy/confluent_platform
terraform init
terraform apply
```

## Teardown

1. Destroy the Confluent Platform:

```bash
cd examples/quickstart_deploy/confluent_platform
terraform destroy
```

2. Uninstall the Confluent Operator and destroy `confluent` namespace:

```bash
cd examples/confluent_operator
terraform destroy
```


## Tests

1. Install [Terraform](https://www.terraform.io/) and make sure it's on your `PATH`.
2. Install [Golang](https://golang.org/) and make sure this code is checked out into your `GOPATH`.
3. `go get github.com/gruntwork-io/terratest/modules/terraform
4. `go mod init test/terraform_confluent_operator_test.go`
5. `cd test`
6. `go test terraform_confluent_operator_test.go -v`
7. `go test terraform_confluent_platform_test.go -v`

Or with the [Makefile](./Makefile)
1. `make install`
2. `make tests`

## Makefile Targets

```
help                      This help.
build                     Build docker dev container
run                       Run docker dev container
install                   Install project
lint                      Lint with pre-commit
lint-all                  Lint with pre-commit
tests                     Test with Terratest
test-confluent-operator   Test confluent-operator Example
test-confluent-platform   Test confluent-platform Example
clean                     Clean project
```
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.8 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.12.1 |
## Providers

No providers.
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_connect"></a> [connect](#module\_connect) | ./modules/connect | n/a |
| <a name="module_control_center"></a> [control\_center](#module\_control\_center) | ./modules/control_center | n/a |
| <a name="module_kafka"></a> [kafka](#module\_kafka) | ./modules/kafka | n/a |
| <a name="module_kafka_rest_proxy"></a> [kafka\_rest\_proxy](#module\_kafka\_rest\_proxy) | ./modules/kafka_rest_proxy | n/a |
| <a name="module_ksqldb"></a> [ksqldb](#module\_ksqldb) | ./modules/ksqldb | n/a |
| <a name="module_schema_registry"></a> [schema\_registry](#module\_schema\_registry) | ./modules/schema_registry | n/a |
| <a name="module_zookeeper"></a> [zookeeper](#module\_zookeeper) | ./modules/zookeeper | n/a |
## Resources

No resources.
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_connect_spec"></a> [connect\_spec](#input\_connect\_spec) | The Connect spec. | `any` | <pre>{<br>  "dependencies": {<br>    "kafka": {<br>      "bootstrapEndpoint": "kafka:9071"<br>    }<br>  },<br>  "image": {<br>    "application": "confluentinc/cp-server-connect:7.2.0",<br>    "init": "confluentinc/confluent-init-container:2.4.0"<br>  },<br>  "replicas": 1<br>}</pre> | no |
| <a name="input_control_center_spec"></a> [control\_center\_spec](#input\_control\_center\_spec) | The ControlCenter spec. | `any` | <pre>{<br>  "dataVolumeCapacity": "10Gi",<br>  "dependencies": {<br>    "connect": [<br>      {<br>        "name": "connect",<br>        "url": "http://connect.confluent.svc.cluster.local:8083"<br>      }<br>    ],<br>    "ksqldb": [<br>      {<br>        "name": "ksqldb",<br>        "url": "http://ksqldb.confluent.svc.cluster.local:8088"<br>      }<br>    ],<br>    "schemaRegistry": {<br>      "url": "http://schemaregistry.confluent.svc.cluster.local:8081"<br>    }<br>  },<br>  "image": {<br>    "application": "confluentinc/cp-enterprise-control-center:7.2.0",<br>    "init": "confluentinc/confluent-init-container:2.4.0"<br>  },<br>  "replicas": 1<br>}</pre> | no |
| <a name="input_kafka_rest_proxy_spec"></a> [kafka\_rest\_proxy\_spec](#input\_kafka\_rest\_proxy\_spec) | The KafkaRestProxy spec. | `any` | <pre>{<br>  "dependencies": {<br>    "schemaRegistry": {<br>      "url": "http://schemaregistry.confluent.svc.cluster.local:8081"<br>    }<br>  },<br>  "image": {<br>    "application": "confluentinc/cp-kafka-rest:7.2.0",<br>    "init": "confluentinc/confluent-init-container:2.4.0"<br>  },<br>  "replicas": 1<br>}</pre> | no |
| <a name="input_kafka_spec"></a> [kafka\_spec](#input\_kafka\_spec) | The Kafka spec. | `any` | <pre>{<br>  "dataVolumeCapacity": "10Gi",<br>  "image": {<br>    "application": "confluentinc/cp-server:7.2.0",<br>    "init": "confluentinc/confluent-init-container:2.4.0"<br>  },<br>  "metricReporter": {<br>    "enabled": true<br>  },<br>  "replicas": 3<br>}</pre> | no |
| <a name="input_ksqldb_spec"></a> [ksqldb\_spec](#input\_ksqldb\_spec) | The KsqlDB spec. | `any` | <pre>{<br>  "dataVolumeCapacity": "10Gi",<br>  "image": {<br>    "application": "confluentinc/cp-ksqldb-server:7.2.0",<br>    "init": "confluentinc/confluent-init-container:2.4.0"<br>  },<br>  "replicas": 1<br>}</pre> | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to replease the confluent platform into. | `string` | `"confluent"` | no |
| <a name="input_schema_registry_spec"></a> [schema\_registry\_spec](#input\_schema\_registry\_spec) | The SchemaRegistry spec. | `any` | <pre>{<br>  "image": {<br>    "application": "confluentinc/cp-schema-registry:7.2.0",<br>    "init": "confluentinc/confluent-init-container:2.4.0"<br>  },<br>  "replicas": 3<br>}</pre> | no |
| <a name="input_zookeeper_spec"></a> [zookeeper\_spec](#input\_zookeeper\_spec) | The Zookeeper spec. | `any` | <pre>{<br>  "dataVolumeCapacity": "10Gi",<br>  "image": {<br>    "application": "confluentinc/cp-zookeeper:7.2.0",<br>    "init": "confluentinc/confluent-init-container:2.4.0"<br>  },<br>  "logVolumeCapacity": "10Gi",<br>  "replicas": 3<br>}</pre> | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connect"></a> [connect](#output\_connect) | The Connect CFK component. |
| <a name="output_control_center"></a> [control\_center](#output\_control\_center) | The ControlCenter CFK component. |
| <a name="output_kafka"></a> [kafka](#output\_kafka) | The Kafka CFK component. |
| <a name="output_kafka_rest_proxy"></a> [kafka\_rest\_proxy](#output\_kafka\_rest\_proxy) | The KafkaRestProxy CFK component. |
| <a name="output_ksqldb"></a> [ksqldb](#output\_ksqldb) | The KsqlDB CFK component. |
| <a name="output_schema_registry"></a> [schema\_registry](#output\_schema\_registry) | The SchemaRegistry CFK component. |
| <a name="output_zookeeper"></a> [zookeeper](#output\_zookeeper) | The Zookeeper CFK component. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache 2 Licensed. See [LICENSE](./LICENSE) for full details.
