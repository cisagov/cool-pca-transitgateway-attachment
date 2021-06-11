#-------------------------------------------------------------------------------
# Create the subnets for the shared services VPC.
#-------------------------------------------------------------------------------
module "private" {
  source = "github.com/cisagov/distributed-subnets-tf-module"
  providers = {
    aws = aws.pca_provisionaccount
  }

  vpc_id             = aws_vpc.pca.id
  subnet_cidr_blocks = var.private_subnet_cidr_blocks
}

module "public" {
  source = "github.com/cisagov/distributed-subnets-tf-module"
  providers = {
    aws = aws.pca_provisionaccount
  }

  vpc_id             = aws_vpc.pca.id
  subnet_cidr_blocks = var.public_subnet_cidr_blocks
}
