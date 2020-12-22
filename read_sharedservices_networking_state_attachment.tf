# ------------------------------------------------------------------------------
# Attach the policy for read-only access to the cool-sharedservices-networking
# state in the Terraform state bucket to the role that allows access to
# PCA-related S3 and DynamoDB resources for a Terraform backend.
# ------------------------------------------------------------------------------

resource "aws_iam_role_policy_attachment" "read_sharedservices_networking_tf_policy_attachment" {
  provider = aws.provisionterraform

  policy_arn = aws_iam_policy.read_sharedservices_networking_tf_state_policy.arn
  role       = data.terraform_remote_state.terraform.outputs.access_pca_terraform_backend_role.name
}
