# hybrid_aws_msk

This example is divided into to four parts

## aws_msk

First, create a new VPC and deploy an MSK and EKS cluster into it. Then try one of the confluent platform deployment.

## confluent_platform

Deploy the Confluent Platform components connected with an AWS MSK cluster over PLAINTEXT. The Confluent Components are also configured with PLAINTEXT.

## confluent_platform_tls_only

Deploy the Confluent Platform components connected with an AWS MSK cluster over TLS. The Confluent Components are also configured with TSL.

## confluent_platform_iam_secure

Deploy the Confluent Platform components connected with an AWS MSK cluster over TLS. Authenticate and Authorize with IAM. Please see [aws-msk-iam-auth](https://github.com/aws/aws-msk-iam-auth) for more information.
