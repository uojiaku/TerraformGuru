provider "aws" {
  region = "us-east-1"
}

module "s3_bucket" {
  source                    =   "terraform-aws-modules/s3-bucket/aws"
  bucket                    =   "odogwu"
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

########### Supporting Resources ##########
# resource "aws_kms_key" "objects" {
#   description             = "KMS key is used to encrypt bucket objects"
#   deletion_window_in_days = 7
# }

################ Bucket Policy #################
data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid     = "OverridePlaceHolderOne"
    effect = "Allow"
    
    principals {
      type          = "*"
      identifiers   = ["*"]
    }
      
    actions = [
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::odogwu/*",  # what buckets and object this applies on 
    ]
  }
}


resource "aws_s3_bucket_policy" "access" {
  bucket = module.s3_bucket.s3_bucket_id 
  policy = data.aws_iam_policy_document.bucket_policy.json
  # policy = jsonencode({
  #   "Version": "2012-10-17",
  #   "Id": "goat234policy",
  #   "Statement": [
  #     {
  #       "Effect": "Allow",
  #       "Principal": "*",
  #       "Action": "s3:GetBucket",
  #       "Resource": "arn:aws:s3:::goat234/*"
  #     }
  #   ]
  # })
}

########## uploaded bear.png file ######### 
## aws s3 cp /c/Users/ucheo/OneDrive/Documents/bear.png s3://goat234

########## delete objects in bucket #######
## aws s3 rm s3://ebube-dike-bucket --recursive
