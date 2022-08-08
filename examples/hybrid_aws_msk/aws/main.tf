module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = var.name
  description = "Security group for ${var.name}"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = module.vpc.private_subnets_cidr_blocks
  ingress_rules       = ["kafka-broker-tcp", "kafka-broker-tls-tcp"]
}

module "msk_cluster" {
  source  = "clowdhaus/msk-kafka-cluster/aws"
  version = "1.2.0"

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

  cloudwatch_logs_enabled = true
}
