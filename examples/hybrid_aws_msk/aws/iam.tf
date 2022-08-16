# https://docs.aws.amazon.com/msk/latest/developerguide/security-iam-awsmanpol.html
# https://docs.aws.amazon.com/msk/latest/developerguide/security_iam_id-based-policy-examples.html
resource "aws_iam_policy" "aws_msk_cluster_full_access" {
  name        = "msk-cluster-full-access"
  path        = "/"
  description = "MSK Cluster full access."

  policy = <<-EOF
  {
      "Version": "2012-10-17",
      "Statement": [
          {
              "Effect": "Allow",
              "Action": [
                  "kafka-cluster:Connect",
                  "kafka-cluster:AlterCluster",
                  "kafka-cluster:DescribeCluster"
              ],
              "Resource": [
                  "${module.msk_cluster.arn}"
              ]
          },
          {
              "Effect": "Allow",
              "Action": [
                  "kafka-cluster:*Topic*",
                  "kafka-cluster:WriteData",
                  "kafka-cluster:ReadData"
              ],
              "Resource": [
                  "arn:aws:kafka:${var.aws_region}:${data.aws_caller_identity.current.account_id}:topic/${var.name}/*"
              ]
          },
          {
              "Effect": "Allow",
              "Action": [
                  "kafka-cluster:AlterGroup",
                  "kafka-cluster:DescribeGroup"
              ],
              "Resource": [
                  "arn:aws:kafka:${var.aws_region}:${data.aws_caller_identity.current.account_id}:group/${var.name}/*"
              ]
          }
      ]
  }
  EOF
}

module "iam_eks_confluent_platform_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-eks-role"
  version = "5.3.0"

  role_name = "confluent-platform"

  cluster_service_accounts = {
    (var.name) = ["${module.confluent_operator.namespace}:confluent-platform"]
  }

  role_policy_arns = {
    aws_msk_cluster_full_access = aws_iam_policy.aws_msk_cluster_full_access.arn
  }
}
