module "acm" {
  source = "../../modules/acm"

  providers = {
    aws           = aws
    aws.us_east_1 = aws.us_east_1
  }

  app                       = var.app
  domain_name               = var.domain_name
  subject_alternative_names = var.subject_alternative_names
}
