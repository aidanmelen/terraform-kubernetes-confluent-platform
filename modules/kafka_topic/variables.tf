variable "name" {
  type        = string
  description = "The name for the CFK component."
  default     = "zookeeper"
}

variable "namespace" {
  type        = string
  description = "The kubernetes namespace for the CFK component."
  default     = "confluent"
}

variable "additional_metadata" {
  type        = any
  description = "The additional kubernetes metadata for the CFK component."
  default     = {}
}

variable "computed_fields" {
  type        = list(string)
  description = "The `computed_fields` block for the kubernetes_manifest resource."
  default = [
    "metadata.finalizers"
  ]
}

variable "replicas" {
  type        = number
  description = "The replicas for the topic."
  default     = 3
}

variable "partition_count" {
  type        = number
  description = "The partition count for the topic."
  default     = 3
}

variable "kafka_cluster_ref" {
  type        = any
  description = "The confluent kafkaClusterRef for the topic."
  default = {
    "name"      = "kafka"
    "namespace" = "confluent"
  }
}

variable "create_timeout" {
  type        = string
  description = "The create timeout."
  default     = "10m"
}

variable "update_timeout" {
  type        = string
  description = "The update timeout."
  default     = "10m"
}

variable "delete_timeout" {
  type        = string
  description = "The delete timeout."
  default     = "10m"
}
