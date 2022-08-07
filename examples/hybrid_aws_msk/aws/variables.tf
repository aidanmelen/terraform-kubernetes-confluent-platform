variable "aws_region" {
  description = "The AWS region name."
  type        = string
  default     = "us-west-2"
}

variable "aws_msk_cluster_name" {
  description = "The AWS MSK cluster name."
  type        = string
  default     = "my-msk-cluster"
}
