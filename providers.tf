# This is the "default" provider that is used assume the roles in the other
# providers.  It uses the credentials of the caller.  It is also used to
# assume the roles required to access remote state in the Terraform backend.

provider "aws" {
  region = var.aws_region
}

# The provider used to create resources inside the PCA account.
provider "aws" {
  alias  = "pca_provisionaccount"
  region = var.aws_region
  assume_role {
    role_arn     = data.terraform_remote_state.pca.outputs.provisionaccount_role.arn
    session_name = local.caller_user_name
  }
}

# The provider used to lookup account IDs.  See locals.
provider "aws" {
  alias  = "organizationsreadonly"
  region = var.aws_region
  assume_role {
    role_arn     = data.terraform_remote_state.master.outputs.organizationsreadonly_role.arn
    session_name = local.caller_user_name
  }
}

# The provider used to manipulate the Transit Gateway in the Shared Services
# account and to associate the PCA VPC with the Route53 (private DNS) zone
# in the Shared Services account.
provider "aws" {
  alias  = "provisionsharedservices"
  region = var.aws_region
  assume_role {
    role_arn     = data.terraform_remote_state.sharedservices.outputs.provisionaccount_role.arn
    session_name = local.caller_user_name
  }
}

# The provider used to attach the policy allowing read-only access to this
# project's Terraform state to the AccessPCATerraformBackend role in
# the Terraform account.
provider "aws" {
  alias  = "provisionterraform"
  region = var.aws_region
  assume_role {
    role_arn     = data.terraform_remote_state.terraform.outputs.provisionaccount_role.arn
    session_name = local.caller_user_name
  }
}
