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
- The following COOL accounts and roles must have been created:
  - Master:
    [`cisagov/cool-accounts/master`](https://github.com/cisagov/cool-accounts/master)
  - PCA:
    [`cisagov/cool-accounts-pca`](https://github.com/cisagov/cool-accounts-pca)
  - Shared Services:
    [`cisagov/cool-accounts/sharedservices`](https://github.com/cisagov/cool-accounts/sharedservices)
  - Terraform:
    [`cisagov/cool-accounts/terraform`](https://github.com/cisagov/cool-accounts/terraform)
  - Users:
    [`cisagov/cool-accounts/users`](https://github.com/cisagov/cool-accounts/users)
- Terraform in
  [`cisagov/cool-sharedservices-networking`](https://github.com/cisagov/cool-sharedservices-networking)
  must have been applied.

## Usage ##

1. Create a Terraform workspace (if you haven't already done so) by running
   `terraform workspace new <workspace_name>`

   **IMPORTANT:** The Terraform workspace name must be the same as an
   existing Terraform workspace for your deployment of
   [`cisagov/cool-accounts-pca`](https://github.com/cisagov/cool-accounts-pca)
   (e.g. `staging`, `production`, etc.) or your deployment will fail.
1. Create a `<workspace_name>.tfvars` file with all of the required
  variables (see [Inputs](#Inputs) below for details):

  ```hcl
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

1. Run the command `terraform init`.
1. Add all necessary permissions by running the command:

   ```console
   terraform apply -var-file=<workspace_name>.tfvars --target=aws_iam_policy.provision_tgw_attachment_policy --target=aws_iam_role_policy_attachment.provision_tgw_attachment_policy_attachment
   ```

1. Create all remaining Terraform infrastructure by running the command:

   ```console
   terraform apply -var-file=<workspace_name>.tfvars
   ```

## Requirements ##

| Name | Version |
|------|---------|
| terraform | ~> 0.13.0 |
| aws | ~> 3.38 |

## Providers ##

| Name | Version |
|------|---------|
| aws | ~> 3.38 |
| aws.organizationsreadonly | ~> 3.38 |
| aws.pca\_provisionaccount | ~> 3.38 |
| aws.provisionsharedservices | ~> 3.38 |
| aws.provisionterraform | ~> 3.38 |
| null | n/a |
| terraform | n/a |

## Modules ##

| Name | Source | Version |
|------|--------|---------|
| private | github.com/cisagov/distributed-subnets-tf-module | n/a |
| public | github.com/cisagov/distributed-subnets-tf-module | n/a |

## Resources ##

| Name | Type |
|------|------|
| [aws_ec2_transit_gateway_route.pca](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route_table_association.pca](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_association) | resource |
| [aws_ec2_transit_gateway_vpc_attachment.pca](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) | resource |
| [aws_iam_policy.provision_tgw_attachment_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.read_terraform_state_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role_policy_attachment.provision_tgw_attachment_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.read_terraform_state_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_route53_vpc_association_authorization.pca](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_vpc_association_authorization) | resource |
| [aws_route53_zone_association.pca](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone_association) | resource |
| [aws_vpc.pca](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [null_resource.break_association_with_default_route_table](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_caller_identity.pca](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.provision_tgw_attachment_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.read_terraform_state_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_organizations_organization.cool](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [terraform_remote_state.master](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.pca](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.sharedservices](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.sharedservices_networking](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.terraform](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_region | The AWS region to deploy into (e.g. us-east-1). | `string` | `"us-east-1"` | no |
| private\_subnet\_cidr\_blocks | The list of private subnet CIDR blocks in the PCA VPC (e.g. ["10.10.2.0/24", "10.10.3.0/24"]). | `list(string)` | n/a | yes |
| provision\_tgw\_attachment\_policy\_description | The description to associate with the IAM policy that allows provisioning of the Transit Gateway attachment in the PCA account. | `string` | `"Allows provisioning of the Transit Gateway attachment in the PCA account."` | no |
| provision\_tgw\_attachment\_policy\_name | The name to assign the IAM policy that allows provisioning of the Transit Gateway attachment in the PCA account. | `string` | `"ProvisionTGWAttachment"` | no |
| public\_subnet\_cidr\_blocks | The list of public subnet CIDR blocks in the PCA VPC (e.g. ["10.10.0.0/24", "10.10.1.0/24"]). | `list(string)` | n/a | yes |
| read\_terraform\_state\_policy\_description | The description to associate with the IAM policy that allows read-only access to the cool-pca-transitgateway-attachment state in the S3 bucket where Terraform state is stored. | `string` | `"Allows read-only access to the cool-pca-transitgateway-attachment state in the S3 bucket where Terraform state is stored."` | no |
| read\_terraform\_state\_policy\_name | The name to assign the IAM policy that allows read-only access to the cool-pca-transitgateway-attachment state in the S3 bucket where Terraform state is stored. | `string` | `"ReadPCATransitGateWayAttachmentTerraformState"` | no |
| tags | Tags to apply to all AWS resources created. | `map(string)` | `{}` | no |
| vpc\_cidr\_block | The CIDR block to use for the PCA VPC (e.g. "10.10.0.0/21"). | `string` | n/a | yes |

## Outputs ##

| Name | Description |
|------|-------------|
| private\_subnets | The private subnets in the PCA VPC. |
| public\_subnets | The public subnets in the PCA VPC. |
| transit\_gateway\_id | The ID of the Transit Gateway in the Shared Services account. |
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
