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

variable "datagen_source_connector_max_interval" {
  description = "Max interval between messages (ms)"
  type        = number
  default     = 500
}

variable "datagen_source_connector_iterations" {
  description = "Number of messages to send from each task, or -1 for unlimited"
  type        = number
  default     = -1
}