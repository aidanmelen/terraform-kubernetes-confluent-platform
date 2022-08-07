variable "aws_msk_cluster_bootstrap_brokers_tls" {
  description = "The AWS MSK cluster bootstrap brokers TLS."
  type        = string
}

variable "namespace" {
  description = "The namespace to release the Confluent Operator and Confluent Platform into."
  type        = string
  default     = "confluent"
}

variable "create_controlcenter" {
  description = "Controls if the ControlCenter component of the Confluent Platform should be created."
  type        = bool
  default     = true
}
