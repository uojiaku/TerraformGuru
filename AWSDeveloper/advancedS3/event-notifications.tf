

## create destination bucket
module "s3_bucket4" {
  source                    =   "terraform-aws-modules/s3-bucket/aws"
  bucket                    =   "goat444"
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
}

###### Bucket Policy #######

data "aws_iam_policy_document" "bucket_policy4" {
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
      "arn:aws:s3:::goat444/*",  # what buckets and object this applies on 
    ]
  }
}

resource "aws_s3_bucket_policy" "access4" {
  bucket = module.s3_bucket4.s3_bucket_id 
  policy = data.aws_iam_policy_document.bucket_policy4.json
}

## create SNS

module "sns_topic1" {
  source  = "terraform-aws-modules/sns/aws"
  version = "~> 3.0"

  name_prefix = "okwu-sns-topic"
}

## create SQS queue

resource "aws_sqs_queue" "this" {
  count = 2
  name  = "okwu-sqs-queue"
}

data "aws_iam_policy_document" "sqs_external" {
  statement {
    effect  = "Allow"
    actions = ["sqs:SendMessage"]
    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }
    resources = [aws_sqs_queue.this[0].arn]
  }
}

resource "aws_sqs_queue_policy" "allow_external" {
  queue_url = aws_sqs_queue.this[0].id
  policy    = data.aws_iam_policy_document.sqs_external.json
}

## s3 Event notifcation

module "s3-bucket_example_notification" {
  source  = "terraform-aws-modules/s3-bucket/aws//modules/notification"
  version = "3.8.2"

  bucket = module.s3_bucket4.s3_bucket_id

  eventbridge = true

   sqs_notifications = {
    sqs1 = {
      queue_arn     = aws_sqs_queue.this[0].arn
      events        = ["s3:ObjectCreated:*"]
      #filter_prefix = "prefix2/"
      #filter_suffix = ".txt"

      #      queue_id =  aws_sqs_queue.this[0].id // optional
    }
  }

   sns_notifications = {
    sns1 = {
      topic_arn     = module.sns_topic1.sns_topic_arn
      events        = ["s3:ObjectRemoved:Delete"]
      #filter_prefix = "prefix3/"
      #filter_suffix = ".csv"
    }
  }
}