# Associate PCA VPC with Shared Services Route53 (private DNS) zone
resource "aws_route53_vpc_association_authorization" "pca" {
  provider = aws.provisionsharedservices

  vpc_id  = aws_vpc.pca.id
  zone_id = data.terraform_remote_state.sharedservices_networking.outputs.private_zone.id
}

resource "aws_route53_zone_association" "pca" {
  provider = aws.pca_provisionaccount

  vpc_id  = aws_route53_vpc_association_authorization.pca.vpc_id
  zone_id = aws_route53_vpc_association_authorization.pca.zone_id
}
