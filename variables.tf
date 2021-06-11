# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------
variable "private_subnet_cidr_blocks" {
  type        = list(string)
  description = "The list of private subnet CIDR blocks in the PCA VPC (e.g. [\"10.10.2.0/24\", \"10.10.3.0/24\"])."
}

variable "public_subnet_cidr_blocks" {
  type        = list(string)
  description = "The list of public subnet CIDR blocks in the PCA VPC (e.g. [\"10.10.0.0/24\", \"10.10.1.0/24\"])."
}

variable "vpc_cidr_block" {
  type        = string
  description = "The CIDR block to use for the PCA VPC (e.g. \"10.10.0.0/21\")."
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------
variable "aws_region" {
  type        = string
  description = "The AWS region to deploy into (e.g. us-east-1)."
  default     = "us-east-1"
}

variable "provision_tgw_attachment_policy_description" {
  type        = string
  description = "The description to associate with the IAM policy that allows provisioning of the Transit Gateway attachment in the PCA account."
  default     = "Allows provisioning of the Transit Gateway attachment in the PCA account."
}

variable "provision_tgw_attachment_policy_name" {
  type        = string
  description = "The name to assign the IAM policy that allows provisioning of the Transit Gateway attachment in the PCA account."
  default     = "ProvisionTGWAttachment"
}

variable "read_terraform_state_policy_description" {
  type        = string
  description = "The description to associate with the IAM policy that allows read-only access to the cool-pca-transitgateway-attachment state in the S3 bucket where Terraform state is stored."
  default     = "Allows read-only access to the cool-pca-transitgateway-attachment state in the S3 bucket where Terraform state is stored."
}

variable "read_terraform_state_policy_name" {
  type        = string
  description = "The name to assign the IAM policy that allows read-only access to the cool-pca-transitgateway-attachment state in the S3 bucket where Terraform state is stored."
  default     = "ReadPCATransitGateWayAttachmentTerraformState"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created."
  default     = {}
}
