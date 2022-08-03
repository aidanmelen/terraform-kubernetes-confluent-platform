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

variable "producer_num_records" {
  description = "The number of messages to produce to 'my-topic'."
  type        = number
  default     = 1000
}
