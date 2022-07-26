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
  description = "The namespace to release the Confluent Operator into."
  type        = string
  default     = "confluent"
}
