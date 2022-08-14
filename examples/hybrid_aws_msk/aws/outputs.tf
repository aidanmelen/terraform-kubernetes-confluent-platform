output "bootstrap_brokers" {
  description = "Comma separated list of one or more hostname:port pairs of kafka brokers suitable to bootstrap connectivity to the kafka cluster"
  value       = module.msk_cluster.bootstrap_brokers
}

output "bootstrap_brokers_tls" {
  description = "One or more DNS names (or IP addresses) and TLS port pairs"
  value       = module.msk_cluster.bootstrap_brokers_tls
}

output "bootstrap_brokers_sasl_iam" {
  description = "One or more DNS names (or IP addresses) and SASL IAM port pairs"
  value       = module.msk_cluster.bootstrap_brokers_sasl_iam
}
