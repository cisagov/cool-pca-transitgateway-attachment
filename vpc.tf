#-------------------------------------------------------------------------------
# Create the PCA VPC.
#-------------------------------------------------------------------------------

resource "aws_vpc" "pca" {
  provider = aws.pca_provisionaccount

  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
}
