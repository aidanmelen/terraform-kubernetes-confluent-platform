variable "namespace" {
  type        = string
  description = "The namespace to release the Confluent Operator and Confluent Platform into."
  default     = "confluent"
}

variable "create_namespace" {
  type        = bool
  description = "Create the namespace if it does not yet exist."
  default     = false
}

variable "namespace_annotations" {
  type        = any
  description = "The namespace annotations."
  default     = null
}

variable "namespace_labels" {
  type        = any
  description = "The namespace labels."
  default     = null
}

variable "create_confluent_operator" {
  type        = bool
  description = "Whether to create the Confluent Operator."
  default     = false
}

variable "confluent_operator_name" {
  type        = string
  description = "The name for the confluent operator."
  default     = "confluent-operator"
}

variable "confluent_operator_repository" {
  type        = string
  description = "Repository URL where to locate the requested chart."
  default     = "https://packages.confluent.io/helm"
}

variable "confluent_operator_chart" {
  type        = string
  description = "Chart name to be installed. The chart name can be local path, a URL to a chart, or the name of the chart if `repository` is specified. It is also possible to use the `<repository>/<chart>` format here if you are running Terraform on a system that the repository has been added to with `helm repo add` but this is not recommended."
  default     = "confluent-for-kubernetes"
}

variable "confluent_operator_chart_version" {
  type        = string
  description = "Specify the exact chart version to install. If this is not specified, the latest version is installed."
  default     = null
}

variable "confluent_operator_wait_for_jobs" {
  type        = bool
  description = "If wait is enabled, will wait until all Jobs have been completed before marking the release as successful. It will wait for as long as `timeout`."
  default     = true
}

variable "create_zookeeper" {
  type        = bool
  description = "Whether to create the Zookeeper component of the Confluent Platform."
  default     = true
}

variable "zookeeper" {
  type        = any
  description = "The Zookeeper mainfest overrides."
  default     = null
}

variable "create_kafka" {
  type        = bool
  description = "Whether to create the Kafka component of the Confluent Platform."
  default     = true
}

variable "kafka" {
  type        = any
  description = "The Kafka mainfest overrides."
  default     = null
}

variable "create_connect" {
  type        = bool
  description = "Whether to create the Connect component of the Confluent Platform."
  default     = true
}

variable "connect" {
  type        = any
  description = "The Connect mainfest overrides."
  default     = null
}

variable "create_ksqldb" {
  type        = bool
  description = "Whether to create the KsqlDB component of the Confluent Platform."
  default     = true
}

variable "ksqldb" {
  type        = any
  description = "The KsqlDB mainfest overrides."
  default     = null
}

variable "create_controlcenter" {
  type        = bool
  description = "Whether to create the ControlCenter component of the Confluent Platform."
  default     = true
}

variable "controlcenter" {
  type        = any
  description = "The ControlCenter mainfest overrides."
  default     = null
}

variable "create_schemaregistry" {
  type        = bool
  description = "Whether to create the SchemaRegistry component of the Confluent Platform."
  default     = true
}

variable "schemaregistry" {
  type        = any
  description = "The SchemaRegistry mainfest overrides."
  default     = null
}

variable "create_kafkarestproxy" {
  type        = bool
  description = "Whether to create the KafkaRestProxy component of the Confluent Platform."
  default     = true
}

variable "kafkarestproxy" {
  type        = any
  description = "The KafkaRestProxy mainfest overrides."
  default     = null
}
