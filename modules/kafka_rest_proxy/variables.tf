variable "name" {
  type        = string
  description = "The name for the CFK component."
  default     = "kafkarestproxy"
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

variable "spec" {
  type        = any
  description = "The kubernetes spec for the CFK component."
  default = {
    "dependencies" = {
      "schemaRegistry" = {
        "url" = "http://schemaregistry.confluent.svc.cluster.local:8081"
      }
    }
    "image" = {
      "application" = "confluentinc/cp-kafka-rest:7.0.1"
      "init"        = "confluentinc/confluent-init-container:2.2.0-1"
    }
    "replicas" = 1
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
