# ------------------------------------------------------------------------------
# Attach to the ProvisionAccount role the IAM policy that allows
# provisioning of the Transit Gateway attachment in the PCA account.
# ------------------------------------------------------------------------------

resource "aws_iam_role_policy_attachment" "provision_tgw_attachment_policy_attachment" {
  provider = aws.pca_provisionaccount

  policy_arn = aws_iam_policy.provision_tgw_attachment_policy.arn
  role       = data.terraform_remote_state.pca.outputs.provisionaccount_role.name
}
