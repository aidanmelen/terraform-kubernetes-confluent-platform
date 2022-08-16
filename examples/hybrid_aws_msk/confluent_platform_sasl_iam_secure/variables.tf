variable "aws_region" {
  description = "The AWS region name."
  type        = string
  default     = "us-west-2"
}

variable "name" {
  description = "The project name."
  type        = string
  default     = "hybrid-aws-msk"
}

variable "namespace" {
  description = "The namespace to release the Confluent Platform into."
  type        = string
  default     = "confluent"
}

variable "create_controlcenter" {
  description = "Controls if the ControlCenter component of the Confluent Platform should be created."
  type        = bool
  default     = true
}
