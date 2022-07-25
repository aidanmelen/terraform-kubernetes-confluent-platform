variable "namespace" {
  type        = string
  description = "The namespace to install the release into."
  default     = "confluent"
}

variable "zookeeper_spec" {
    description = "The Zookeeper spec."
    default = {}
}

variable "kafka_spec" {
    description = "The Kafka spec."
    default = {}
}

variable "connect_spec" {
    description = "The Connect spec."
    default = {}
}

variable "ksqldb_spec" {
    description = "The KsqlDB spec."
    default = {}
}

variable "control_center_spec" {
    description = "The ControlCenter spec."
    default = {}
}

variable "schema_registry_spec" {
    description = "The SchemaRegistry spec."
    default = {}
}

variable "kafka_rest_proxy_spec" {
    description = "The KafkaRestProxy spec."
    default = {}
}