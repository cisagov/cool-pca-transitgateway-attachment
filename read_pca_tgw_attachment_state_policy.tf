# ------------------------------------------------------------------------------
# Create the IAM policy that allows read-only access to the Terraform state
# for this project in the S3 bucket where Terraform remote state is stored.
# This is useful for cases when read-only access to this project's state
# data is needed, but read-only access to other Terraform states in the bucket
# is not.
# ------------------------------------------------------------------------------

# IAM policy document that allows read-only access to this project's state
# in the Terraform state bucket.
data "aws_iam_policy_document" "read_terraform_state_doc" {
  statement {
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      data.terraform_remote_state.terraform.outputs.state_bucket.arn,
    ]
  }

  statement {
    actions = [
      "s3:GetObject",
    ]
    resources = [
      "${data.terraform_remote_state.terraform.outputs.state_bucket.arn}/env:/*/cool-pca-transitgateway-attachment/*",
    ]
  }
}

# IAM policy for read-only access to this project's Terraform state
resource "aws_iam_policy" "read_terraform_state_policy" {
  provider = aws.provisionterraform

  description = var.read_terraform_state_policy_description
  name        = var.read_terraform_state_policy_name
  policy      = data.aws_iam_policy_document.read_terraform_state_doc.json
}
