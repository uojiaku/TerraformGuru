module "s3_bucket8" {
  source                    =   "terraform-aws-modules/s3-bucket/aws"
  bucket                    =   "goat999"
  block_public_policy       =   false
  block_public_acls         =   false
  ignore_public_acls        =   false
  restrict_public_buckets   =   false
  #acl    = "private"
  versioning = {
   # enabled = false   // to disable bucket versioning
   enabled = true
  }

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        # kms_master_key_id = aws_kms_key.objects.arn
        # sse_algorithm     = "aws:kms"
        sse_algorithm       = "AES256"
      }
    }
  }

  website = {

    index_document = "index.html"
    error_document = "error.html"
    
  }
}

################ Bucket Policy #################
data "aws_iam_policy_document" "bucket_policy8" {
  statement {
    sid     = "OverridePlaceHolderOne"
    effect = "Allow"
    
    principals {
      type          = "Service"
      identifiers   = ["cloudfront.amazonaws.com"]
    }
      
    actions = [
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::goat999/*",  # what buckets and object this applies on 
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = ["${resource.aws_cloudfront_distribution.this.arn}"]
    }
  }
}


resource "aws_s3_bucket_policy" "access8" {
  bucket = module.s3_bucket8.s3_bucket_id 
  policy = data.aws_iam_policy_document.bucket_policy8.json
}

