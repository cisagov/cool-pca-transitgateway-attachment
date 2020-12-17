# cool-pca-transitgateway-attachment #

[![GitHub Build Status](https://github.com/cisagov/cool-pca-transitgateway-attachment/workflows/build/badge.svg)](https://github.com/cisagov/cool-pca-transitgateway-attachment/actions)

This project is used to create the initial resources required in order to
apply the Terraform code in
[`cisagov/con-pca-cicd`](https://github.com/cisagov/con-pca-cicd).

## Pre-requisites ##

- [Terraform](https://www.terraform.io/) installed on your system.
- An accessible AWS S3 bucket to store Terraform state
  (specified in [`backend.tf`](backend.tf)).
- An accessible AWS DynamoDB database to store the Terraform state lock
  (specified in [`backend.tf`](backend.tf)).
- Access to all of the Terraform remote states specified in
  [`remote_states.tf`](remote_states.tf).
- A Terraform [variables](variables.tf) file customized for your
  environment, for example:

  ```console
  private_subnet_cidr_blocks = [
    "10.10.2.0/24",
    "10.10.3.0/24",
  ]
  public_subnet_cidr_blocks = [
    "10.10.0.0/24",
    "10.10.1.0/24",
  ]
  vpc_cidr_block = "10.10.0.0/21"
  ```

## Building the Terraform-based infrastructure ##

1. Create a Terraform workspace (if you haven't already done so) for
   your assessment by running `terraform workspace new <workspace_name>`.

   **IMPORTANT:** The Terraform workspace name must be the same as an
   existing Terraform workspace for your deployment of
   [`cisagov/cool-accounts-pca`](https://github.com/cisagov/cool-accounts-pca)
   (e.g. `staging`, `production`, etc.) or your deployment will fail.
1. Create a `<workspace_name>.tfvars` file with all of the required
   variables (see [Inputs](#Inputs) below for details).
1. Run the command `terraform init`.
1. Add all necessary permissions by running the command:

   ```console
   terraform apply -var-file=<workspace_name>.tfvars --target=aws_iam_policy.provision_tgw_attachment_policy --target=aws_iam_role_policy_attachment.provision_tgw_attachment_policy_attachment
   ```

1. Create all remaining Terraform infrastructure by running the command:

   ```console
   terraform apply -var-file=<workspace_name>.tfvars

## Requirements ##

| Name | Version |
|------|---------|
| terraform | ~> 0.12.0 |
| aws | ~> 3.0 |

## Providers ##

| Name | Version |
|------|---------|
| aws | ~> 3.0 |
| aws.organizationsreadonly | ~> 3.0 |
| aws.pca_provisionaccount | ~> 3.0 |
| aws.provisionsharedservices | ~> 3.0 |
| aws.provisionterraform | ~> 3.0 |
| null | n/a |
| terraform | n/a |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws_region | The AWS region to deploy into (e.g. us-east-1) | `string` | `us-east-1` | no |
| private_subnet_cidr_blocks | The list of private subnet CIDR blocks in the PCA VPC (e.g. ["10.10.2.0/24", "10.10.3.0/24"]). | `list(string)` | n/a | yes |
| provision_tgw_attachment_policy_description | The description to associate with the IAM policy that allows provisioning of the Transit Gateway attachment in the PCA account. | `string` | `Allows provisioning of the Transit Gateway attachment in the PCA account.` | no |
| provision_tgw_attachment_policy_name | The name to assign the IAM policy that allows provisioning of the Transit Gateway attachment in the PCA account. | `string` | `ProvisionTGWAttachment` | no |
| public_subnet_cidr_blocks | The list of public subnet CIDR blocks in the PCA VPC (e.g. ["10.10.0.0/24", "10.10.1.0/24"]). | `list(string)` | n/a | yes |
| read_terraform_state_policy_description | The description to associate with the IAM policy that allows read-only access to the cool-pca-transitgateway-attachment state in the S3 bucket where Terraform state is stored. | `string` | `Allows read-only access to the cool-pca-transitgateway-attachment state in the S3 bucket where Terraform state is stored.` | no |
| read_terraform_state_policy_name | The name to assign the IAM policy that allows read-only access to the cool-pca-transitgateway-attachment state in the S3 bucket where Terraform state is stored. | `string` | `ReadPCATransitGateWayAttachmentTerraformState` | no |
| tags | Tags to apply to all AWS resources created | `map(string)` | `{}` | no |
| vpc_cidr_block | The CIDR block to use for the PCA VPC (e.g. "10.10.0.0/21"). | `string` | n/a | yes |

## Outputs ##

| Name | Description |
|------|-------------|
| private_subnets | The private subnets in the PCA VPC. |
| public_subnets | The public subnets in the PCA VPC. |
| transit_gateway_id | The ID of the Transit Gateway in the Shared Services account. |
| vpc | The PCA VPC. |

## Notes ##

Running `pre-commit` requires running `terraform init` in every directory that
contains Terraform code. In this repository, this is just the main directory.

## Contributing ##

We welcome contributions!  Please see [`CONTRIBUTING.md`](CONTRIBUTING.md) for
details.

## License ##

This project is in the worldwide [public domain](LICENSE).

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain
dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.
