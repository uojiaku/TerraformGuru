provider "aws" {
  region = "us-east-1"
  profile = "Uche"
}

// create repo
resource "aws_codecommit_repository" "beta" {
  repository_name = "Beta"
  description     = "This is the Sample App Repository"
}

// create topic
resource "aws_sns_topic" "myuser_updates" {
  name = "codecommit-lab"
}

// generate policy document
data "aws_iam_policy_document" "doc_policy" {
  statement {
    actions = ["sns:Publish"]

    principals {
      type        = "Service"
      identifiers = ["codestar-notifications.amazonaws.com"]
    }

    resources = [aws_sns_topic.myuser_updates.arn]
  }
}

// create policy
resource "aws_sns_topic_policy" "default" {
  arn    = aws_sns_topic.myuser_updates.arn
  policy = data.aws_iam_policy_document.doc_policy.json
}

// iam user
# resource "aws_iam_user" "alpha" {
#   name = "alpha"
# }

// service role
resource "aws_iam_service_specific_credential" "codestar_service" {
  service_name = "codestar.amazonaws.com"
  user_name    = "Uche"
}

// create notification rule
resource "aws_codestarnotifications_notification_rule" "commits" {
  name     = "code-repo-commits"
  // link to code repo
  resource = aws_codecommit_repository.beta.arn

  detail_type    = "FULL"
  event_type_ids = [
   "codecommit-repository-comments-on-commits",
   "codecommit-repository-comments-on-pull-requests",
   "codecommit-repository-approvals-status-changed",
   "codecommit-repository-pull-request-created",
   "codecommit-repository-pull-request-merged",
   "codecommit-repository-branches-and-tags-updated"
   ]
  // link to sns topic
  target {
    address = aws_sns_topic.myuser_updates.arn
  }
}

// Trigger
resource "aws_codecommit_trigger" "test" {
  repository_name = aws_codecommit_repository.beta.repository_name

  trigger {
    name            = "all"
    events          = ["all"]
    destination_arn = aws_sns_topic.myuser_updates.arn
  }
}