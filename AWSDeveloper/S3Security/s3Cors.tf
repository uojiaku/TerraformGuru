provider "aws" {
  region = "us-east-1"
}

module "s3_bucket6" {
  source                    =   "terraform-aws-modules/s3-bucket/aws"
  bucket                    =   "goat666"
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


########### Bucket Policy ###############
data "aws_iam_policy_document" "bucket_policy6" {
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
      "arn:aws:s3:::goat666/*",  # what buckets and object this applies on 
    ]
  }
}


resource "aws_s3_bucket_policy" "access6" {
  bucket = module.s3_bucket6.s3_bucket_id 
  policy = data.aws_iam_policy_document.bucket_policy6.json

}

########## uploaded bear.png file ######### 
## aws s3 cp /c/Users/ucheo/OneDrive/Documents/bear.png s3://goat234

########## delete objects in bucket #######
## aws s3 rm s3://ebube-dike-bucket --recursive

################ S3 second bucket #################
# s3  

data "aws_iam_policy_document" "bucket_policy7" {
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
      "arn:aws:s3:::goat777/*",  # what buckets and object this applies on 
    ]
  }
}


resource "aws_s3_bucket_policy" "access7" {
  bucket = module.s3_bucket7.s3_bucket_id 
  policy = data.aws_iam_policy_document.bucket_policy7.json
}

## create second bucket
module "s3_bucket7" {
  source                    =   "terraform-aws-modules/s3-bucket/aws"
  bucket                    =   "goat777"
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

        sse_algorithm       = "AES256"
      }
    }
  }

  website = {

    index_document = "index.html"
    error_document = "error.html"
    
  }

     // cors rule
  cors_rule = [
    {
      allowed_methods = ["GET"]
      allowed_origins = ["http://goat666.s3-website-us-east-1.amazonaws.com"]
      allowed_headers = ["Authorization"]
      expose_headers  = []
      max_age_seconds = 3000
    }
  ]
 
}


// upload index.html & bear.png to goat666
// upload extra-page.html to goat777




