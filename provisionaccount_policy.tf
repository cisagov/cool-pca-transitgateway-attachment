# ------------------------------------------------------------------------------
# Create the IAM policy that allows all of the permissions necessary
# to provision the Transit Gateway attachment in the PCA account.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "provision_tgw_attachment_policy_doc" {
  statement {
    actions = [
      "ec2:CreateSubnet",
      "ec2:CreateTags",
      "ec2:CreateTransitGatewayVpcAttachment",
      "ec2:CreateVpc",
      "ec2:DeleteSubnet",
      "ec2:DeleteTransitGatewayVpcAttachment",
      "ec2:DeleteVpc",
      "ec2:Describe*",
      "ec2:ModifyTransitGatewayVpcAttachment",
      "ec2:ModifyVpcAttribute",
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "provision_tgw_attachment_policy" {
  provider = aws.pca_provisionaccount

  description = var.provision_tgw_attachment_policy_description
  name        = var.provision_tgw_attachment_policy_name
  policy      = data.aws_iam_policy_document.provision_tgw_attachment_policy_doc.json
}
