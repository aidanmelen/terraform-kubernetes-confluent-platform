variable "name" {
  type        = string
  description = "The name for the CFK component."
  default     = "controlcenter"
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

variable "create_timeout" {
  type        = string
  description = "The create timeout."
  default     = "20m"
}

variable "update_timeout" {
  type        = string
  description = "The update timeout."
  default     = "20m"
}

variable "delete_timeout" {
  type        = string
  description = "The delete timeout."
  default     = "10m"
}
