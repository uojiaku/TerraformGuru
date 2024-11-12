provider "aws" {
  region = "us-east-1"
}

module "s3_bucket" {
  source                    =   "terraform-aws-modules/s3-bucket/aws"
  bucket                    =   "goat111"
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
      "arn:aws:s3:::goat111/*",  # what buckets and object this applies on 
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

################ S3 replication #################
# s3  

data "aws_iam_policy_document" "bucket_policy2" {
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
      "arn:aws:s3:::goat222/*",  # what buckets and object this applies on 
    ]
  }
}


resource "aws_s3_bucket_policy" "access2" {
  bucket = module.s3_bucket2.s3_bucket_id 
  policy = data.aws_iam_policy_document.bucket_policy2.json
}

## create destination bucket
module "s3_bucket2" {
  source                    =   "terraform-aws-modules/s3-bucket/aws"
  bucket                    =   "goat222"
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

  lifecycle_rule = [
    {
      id      = "log"
      enabled = true
      
      transition = [
        {
          days          = 30
          storage_class = "ONEZONE_IA"
          }, {
          days          = 60
          storage_class = "GLACIER"
        }
      ]
   
    },
    
  ]
}
# Create IAM Role for S3 to replicate objects

data "aws_iam_policy_document" "assume-role-rights" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "assume-role-rights" {
  name               = "assume-role-rights"
  assume_role_policy = data.aws_iam_policy_document.assume-role-rights.json
}

# Create IAM Policy for S3 to replicate objects

data "aws_iam_policy_document" "policy-replication-rights" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetReplicationConfiguration",
      "s3:ListBucket",
    ]

    resources = [module.s3_bucket.s3_bucket_arn]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObjectVersionForReplication",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionTagging",
    ]

    resources = ["${module.s3_bucket.s3_bucket_arn}/*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:ReplicateObject",
      "s3:ReplicateDelete",
      "s3:ReplicateTags",
    ]

    resources = ["${module.s3_bucket2.s3_bucket_arn}/*"]
  }
}

resource "aws_iam_policy" "create-policy-replication-rights" {
  name   = "create-policy-replication-rights"
  policy = data.aws_iam_policy_document.policy-replication-rights.json
}

## attachment

resource "aws_iam_role_policy_attachment" "attach-role-and-policy" {
  role       = aws_iam_role.assume-role-rights.name
  policy_arn = aws_iam_policy.create-policy-replication-rights.arn
}

# Replicate from source to destination bucket

resource "aws_s3_bucket_replication_configuration" "replication" {
  # Must have bucket versioning enabled first

  role   = aws_iam_role.assume-role-rights.arn
  bucket = module.s3_bucket.s3_bucket_id

  rule {
    id = "repl1"
    status  = "Enabled"
    filter {}

    delete_marker_replication {
      status = "Enabled"
    }

    # existing_object_replication {
    #   status = "Enabled"
    # }

    destination {
      bucket        = module.s3_bucket2.s3_bucket_arn
      storage_class = "STANDARD"
    }
  }
}

# Replicate from destination to source bucket -  to set up redo the policy document

# resource "aws_s3_bucket_replication_configuration" "replication2" {
#   # Must have bucket versioning enabled first

#   role   = aws_iam_role.assume-role-rights.arn
#   bucket = module.s3_bucket2.s3_bucket_id

#   rule {
#     id  = "repl2"
#     filter {}
#     status = "Enabled"

#     delete_marker_replication {
#       status = "Enabled"
#     }
#     destination {
#       bucket        = module.s3_bucket.s3_bucket_arn
#       storage_class = "STANDARD"
#     }
#   }
# }