provider "aws" {
  region = "us-east-1"
}


resource "aws_cloudfront_distribution" "this" {
  origin {
    domain_name = module.s3_bucket8.s3_bucket_bucket_domain_name
    origin_id = "myorigin"
    origin_access_control_id = resource.aws_cloudfront_origin_access_control.this.id
  }

  enabled = true
  default_root_object = "index.html"
  wait_for_deployment = false
  price_class         = "PriceClass_All"

  default_cache_behavior {
    compress                    = true
    viewer_protocol_policy      = "allow-all"
    allowed_methods             = ["GET", "HEAD"]
    target_origin_id            = "myorigin"
    cached_methods              = ["GET", "HEAD"]
    forwarded_values {
      query_string = false
       cookies {
        forward = "none"
      }
  }

  
  }

    restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE"]
    }
  }

   viewer_certificate {
    cloudfront_default_certificate = true
  }

}

resource "aws_cloudfront_origin_access_control" "this" {
  name                              = module.s3_bucket8.s3_bucket_bucket_domain_name
  description                       = "OAC Goat Policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
} 

## Run these commands too
## aws s3 cp index.html s3://goat999
## aws s3 cp bear.png s3://goat999