# https://docs.aws.amazon.com/msk/latest/developerguide/security_iam_id-based-policy-examples.html
# https://docs.aws.amazon.com/msk/latest/developerguide/security-iam-awsmanpol.html

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

resource "aws_iam_role_policy_attachment" "attachment" {
  role       = aws_iam_role.aws_msk_full_access.arn
  policy_arn = "arn:aws:iam::aws:policy/AmazonMSKFullAccess"
}

resource "aws_iam_role_policy_attachment" "aws_msk_full_access" {
  role       = aws_iam_role.aws_msk_full_access.arn
  policy_arn = "arn:aws:iam::aws:policy/AmazonMSKFullAccess"
}
