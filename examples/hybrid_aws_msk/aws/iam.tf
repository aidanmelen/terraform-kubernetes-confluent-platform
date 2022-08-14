# https://docs.aws.amazon.com/msk/latest/developerguide/security_iam_id-based-policy-examples.html
# https://docs.aws.amazon.com/msk/latest/developerguide/security-iam-awsmanpol.html
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "trust" {
  version = "2012-10-17"

  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = [module.eks.oidc_provider_arn]
    }

    actions = ["sts:AssumeRoleWithIdentity"]

    condition {
      test     = "StringEquals"
      variable = "${module.eks.oidc_provider_arn}:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "aws_msk_full_access" {
  name               = "aws_msk-full-access"
  assume_role_policy = data.aws_iam_policy_document.trust.json
}

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
                  ${module.msk_cluster.arn}
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

resource "aws_iam_role_policy_attachment" "attachment" {
  role       = aws_iam_role.aws_msk_full_access.arn
  policy_arn = aws_iam_policy.aws_msk_cluster_full_access.arn
}