variable "aws_profile" {
  type        = string
  description = "The AWS CLI profile to use for authentication."
}

variable "domain_name" {
  type        = string
  description = "The domain name to be used for the CloudFront distribution."
}

variable "index_document" {
  type        = string
  description = "The default index document for the S3 bucket."
  default     = "index.html"
}

variable "name" {
  type        = string
  description = "The name of the project or resource."
}

variable "price_class" {
  type        = string
  description = "The CloudFront price class to use."
  default     = "PriceClass_100"
}

variable "repository" {
  type = object({
    url    = string
    token  = string
    branch = string
  })
  description = "Repository information including URL, access token, and branch to clone."
}

variable "ttl_default" {
  type        = number
  description = "Default TTL for CloudFront caching (in seconds)."
  default     = 604800 # 1 week
}

variable "ttl_max" {
  type        = number
  description = "Maximum TTL for CloudFront caching (in seconds)."
  default     = 2592000 # 30 days
}

variable "ttl_min" {
  type        = number
  description = "Minimum TTL for CloudFront caching (in seconds)."
  default     = 86400 # 1 day
}
