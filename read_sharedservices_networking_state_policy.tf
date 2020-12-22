# ------------------------------------------------------------------------------
# Create the IAM policy that allows read-only access to the
# cool-sharedservices-networking Terraform state in the S3 bucket where
# Terraform remote state is stored.  This is useful for cases when read-only
# access to that state is needed, but read-only access to other Terraform
# states in the bucket is not.
# ------------------------------------------------------------------------------

# IAM policy document that allows read-only access to the
# cool-sharedservices-networking state in the Terraform state bucket.
data "aws_iam_policy_document" "read_sharedservices_networking_tf_state_doc" {
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
      "${data.terraform_remote_state.terraform.outputs.state_bucket.arn}/env:/*/cool-sharedservices-networking/*",
    ]
  }
}

# IAM policy for read-only access to cool-sharedservices-networking
# Terraform state
resource "aws_iam_policy" "read_sharedservices_networking_tf_state_policy" {
  provider = aws.provisionterraform

  description = var.read_sharedservices_networking_tf_state_policy_description
  name        = var.read_sharedservices_networking_tf_state_policy_name
  policy      = data.aws_iam_policy_document.read_sharedservices_networking_tf_state_doc.json
}
