# aws_msk

Create a new VPC and deploy an MSK and EKS cluster into it.

## Assumptions

This example assumes that you have valid AWS credentials set for the default profile.

## EKS Connect

Add the EKS cluster context to the kube config file with the following command:

```bash
aws eks update-kubeconfig --name hybrid-aws-msk
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Example

```hcl
module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = var.name
  description = "Security group for ${var.name}"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = module.vpc.private_subnets_cidr_blocks
  ingress_rules       = ["kafka-broker-tcp", "kafka-broker-tls-tcp"]

  # https://github.com/terraform-aws-modules/terraform-aws-security-group/pull/248
  ingress_with_cidr_blocks = [
    {
      from_port   = 9098
      to_port     = 9098
      protocol    = "tcp"
      description = "kafka-broker-iam-tcp"
      cidr_blocks = module.vpc.private_subnets_cidr_blocks
    }
  ]
}

module "msk_cluster" {
  source = "github.com/aidanmelen/terraform-aws-msk-kafka-cluster@v1.3.0"

  # https://github.com/clowdhaus/terraform-aws-msk-kafka-cluster/pull/4
  # source  = "clowdhaus/msk-kafka-cluster/aws"
  # version = "1.3.0"

  name                   = var.name
  number_of_broker_nodes = 3

  # https://docs.confluent.io/platform/current/installation/versions-interoperability.html#cp-and-apache-ak-compatibility
  kafka_version = "3.2.0"

  broker_node_client_subnets  = module.vpc.private_subnets
  broker_node_ebs_volume_size = 20
  broker_node_instance_type   = "kafka.t3.small"
  broker_node_security_groups = [module.security_group.security_group_id]

  encryption_in_transit_client_broker = "TLS_PLAINTEXT"
  encryption_in_transit_in_cluster    = true

  client_unauthenticated_access_enabled = true
  client_authentication_iam             = true
  client_authentication_sasl_scram      = false

  cloudwatch_logs_enabled = true
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.8 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.72 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.0.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.12.1 |
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_confluent_operator"></a> [confluent\_operator](#module\_confluent\_operator) | ../../../modules/confluent_operator | n/a |
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | >= 18.0.0 |
| <a name="module_msk_cluster"></a> [msk\_cluster](#module\_msk\_cluster) | github.com/aidanmelen/terraform-aws-msk-kafka-cluster@v1.3.0 | n/a |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | terraform-aws-modules/security-group/aws | ~> 4.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 3.0 |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region name. | `string` | `"us-west-2"` | no |
| <a name="input_name"></a> [name](#input\_name) | The project name. | `string` | `"hybrid-aws-msk"` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bootstrap_brokers"></a> [bootstrap\_brokers](#output\_bootstrap\_brokers) | Comma separated list of one or more hostname:port pairs of kafka brokers suitable to bootstrap connectivity to the kafka cluster |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
