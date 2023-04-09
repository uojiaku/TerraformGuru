

resource "aws_cloudfront_distribution" "this2" {
  origin {
    domain_name = module.s3_bucket9.s3_bucket_bucket_domain_name
    origin_id = "myorigin2"
    origin_access_control_id = resource.aws_cloudfront_origin_access_control.this2.id
  }

  enabled = true
  default_root_object = "index.html"
  wait_for_deployment = false
  price_class         = "PriceClass_All"

  default_cache_behavior {
    compress                    = true
    viewer_protocol_policy      = "allow-all"
    allowed_methods             = ["GET", "HEAD"]
    target_origin_id            = "myorigin2"
    cached_methods              = ["GET", "HEAD"]
    forwarded_values {
      query_string = false
       cookies {
        forward = "none"
      }
    }
  }
// cache invalidation

  provisioner "local-exec" {
    command = "aws cloudfront create-invalidation --distribution-id ${self.id} --paths /*"
  }

  # to create another caching behavior

#    ordered_cache_behavior {
#     path_pattern     = "/content/immutable/*"
#     allowed_methods  = ["GET", "HEAD", "OPTIONS"]
#     cached_methods   = ["GET", "HEAD", "OPTIONS"]
#     target_origin_id = local.s3_origin_id

#     forwarded_values {
#       query_string = false
#       headers      = ["Origin"]

#       cookies {
#         forward = "none"
#       }
# #     }

#     min_ttl                = 0
#     default_ttl            = 86400
#     max_ttl                = 31536000
#     compress               = true
#     viewer_protocol_policy = "redirect-to-https"
#   }

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


resource "aws_cloudfront_origin_access_control" "this2" {
  name                              = module.s3_bucket9.s3_bucket_bucket_domain_name
  description                       = "OAC Goat Policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
} 

## Run these commands too
## aws s3 cp index.html s3://goat999
## aws s3 cp bear.png s3://goat999