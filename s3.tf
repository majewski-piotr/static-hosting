data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "website" {
  bucket        = "${var.name}-static-web-files-${data.aws_caller_identity.current.account_id}"
  force_destroy = true
}

resource "aws_s3_bucket_website_configuration" "website_config" {
  bucket = aws_s3_bucket.website.bucket

  index_document {
    suffix = var.index_document
  }
}

resource "aws_s3_bucket_policy" "website_policy" {
  bucket = aws_s3_bucket.website.bucket

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          Service = "cloudfront.amazonaws.com"
        },
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.website.arn}/*",
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.website.id}"
          }
        }
      }
    ]
  })
}

resource "null_resource" "sync_repo_to_s3" {
  provisioner "local-exec" {
    command = <<-EOT
      rm -rf ./${var.name}
      git clone --branch ${var.repository.branch} ${var.repository.url} ./${var.name}
      aws s3 sync ./${var.name} s3://${aws_s3_bucket.website.bucket} --delete --exclude ".*" --size-only --profile ${var.aws_profile}
    EOT
  }

  triggers = {
    always = timestamp()
  }
}
