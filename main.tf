terraform {
 required_providers {
   aws = {
     source = "hashicorp/aws"
   }
 }
}
    
provider "aws" {
  region = "us-east-1"
  shared_credentials_files = ["$HOME/.aws/credentials"]
}

# create table
resource "aws_dynamodb_table" "products" {
 name = "products"
 billing_mode = "PROVISIONED"
 read_capacity= "1"
 write_capacity= "1"
 attribute {
  name = "region"
  type = "S"
 }

 hash_key = "region"
}

# create table items
resource "aws_dynamodb_table_item" "item1" {
  table_name = aws_dynamodb_table.products.name
  hash_key   = aws_dynamodb_table.products.hash_key

  item = <<ITEM
{
  "region": {"S": "us"},
  "product_name": {"S": "jeans_type_1"},
  "id": {"S": "481ee6ce-"}
}
ITEM

}


resource "aws_dynamodb_table_item" "item2" {
  table_name = aws_dynamodb_table.products.name
  hash_key   = aws_dynamodb_table.products.hash_key

  item = <<ITEM
{
  "region": {"S": "eur"},
  "product_name": {"S": "jacket_type_2"},
  "id": {"S": "26279956-"}
}
ITEM

}

resource "aws_dynamodb_table_item" "item3" {
  table_name = aws_dynamodb_table.products.name
  hash_key   = aws_dynamodb_table.products.hash_key

  item = <<ITEM
{
  "region": {"S": "apac"},
  "product_name": {"S": "shirt_type_3"},
  "id": {"S": "534rrt58-"}
}
ITEM

}

# policy creation
resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# policy attachment
resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
    role = aws_iam_role.lambda_role.name
    policy_arn = aws_iam_policy.iam_policy_for_lambda.arn
}

# Archive from content
data "archive_file" "zip_the_python_code" {
    type = "zip"
    source = "/Users/ojiakuboss/Documents/TerraformGuru/pyguy"
    output_path = "/Users/ojiakuboss/Documents/TerraformGuru/pyguy.zip"
}

resource "aws_lambda_function" "test_lambda" {
  # If the file is not in the current working directory you will need to include a 
  # path.module in the filename.
  filename      = "lambda_function_payload.zip"
  function_name = "lambda_function_name"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.test"
  runtime = "python3.8"

  environment {
    variables = {
      foo = "bar"
    }
  }
}