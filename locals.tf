# ------------------------------------------------------------------------------
# Retrieve the caller identity for the PCA account in order to
# get the associated Account ID.
# ------------------------------------------------------------------------------
data "aws_caller_identity" "pca" {
  provider = aws.pca_provisionaccount
}

# ------------------------------------------------------------------------------
# Retrieve the effective Account ID, User ID, and ARN in which Terraform is
# authorized.  This is used to calculate the session names for assumed roles.
# ------------------------------------------------------------------------------
data "aws_caller_identity" "current" {}

# ------------------------------------------------------------------------------
# Retrieve the information for all accouts in the organization.  This is used
# to lookup the Users account ID for use in the assume role policy.
# ------------------------------------------------------------------------------
data "aws_organizations_organization" "cool" {
  provider = aws.organizationsreadonly
}

# ------------------------------------------------------------------------------
# Evaluate expressions for use throughout this configuration.
# ------------------------------------------------------------------------------
locals {
  # The PCA account ID
  pca_account_id = data.aws_caller_identity.pca.account_id

  # Extract the user name of the current caller for use
  # as assume role session names.
  caller_user_name = split("/", data.aws_caller_identity.current.arn)[1]

  # Look up PCA account name from AWS organizations provider
  pca_account_name = [
    for account in data.aws_organizations_organization.cool.accounts :
    account.name
    if account.id == local.pca_account_id
  ][0]

  # Determine account type based on account name.
  #
  # The account name format is "ACCOUNT_NAME (ACCOUNT_TYPE)" - for
  # example, "PCA (Production)".
  pca_account_type = length(regexall("\\(([^()]*)\\)", local.pca_account_name)) == 1 ? regex("\\(([^()]*)\\)", local.pca_account_name)[0] : "Unknown"
  workspace_type   = lower(local.pca_account_type)

  # The ID of the Transit Gateway in the Shared Services account.
  transit_gateway_id = data.terraform_remote_state.sharedservices_networking.outputs.transit_gateway.id
  # The ID of the default route table associated with the Transit
  # Gateway in the Shared Services account.
  transit_gateway_default_route_table_id = data.terraform_remote_state.sharedservices_networking.outputs.transit_gateway.association_default_route_table_id
  # The ID of the route table to be associated with the Transit
  # Gateway attachment for this PCA account.
  transit_gateway_route_table_id = data.terraform_remote_state.sharedservices_networking.outputs.transit_gateway_attachment_route_tables[local.pca_account_id].id
}
