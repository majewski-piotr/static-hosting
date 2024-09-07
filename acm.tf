resource "aws_acm_certificate" "subdomain" {
  provider          = aws.us-east
  domain_name       = "${var.name}.${var.domain_name}"
  validation_method = "DNS"

  subject_alternative_names = [
    "${var.name}.${var.domain_name}"
  ]
}

resource "aws_acm_certificate_validation" "subdomain" {
  provider        = aws.us-east
  certificate_arn = aws_acm_certificate.subdomain.arn

  validation_record_fqdns = [
    for record in aws_acm_certificate.subdomain.domain_validation_options : record.resource_record_name
  ]
}

output "acm_certificate_validation_records" {
  value = {
    for option in aws_acm_certificate.subdomain.domain_validation_options : option.domain_name => {
      name  = option.resource_record_name
      type  = option.resource_record_type
      value = option.resource_record_value
    }
  }
}
