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

# role creation
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

# policy creation
resource "aws_iam_policy" "iam_policy_for_lambda" {
 
 name         = "aws_iam_policy_for_terraform_aws_lambda_role"
 path         = "/"
 description  = "AWS IAM Policy for managing aws lambda role"
 policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": [
       "logs:CreateLogGroup",
       "logs:CreateLogStream",
       "logs:PutLogEvents"
     ],
     "Resource": "arn:aws:logs:*:*:*",
     "Effect": "Allow"
   }
 ]
}
EOF
}

# policy attachment
resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
    role = aws_iam_role.iam_for_lambda.name
    policy_arn = aws_iam_policy.iam_policy_for_lambda.arn
}

# archive from content
data "archive_file" "zip_the_python_code" {
    type = "zip"
    source_dir = "/Users/ojiakuboss/Documents/TerraformGuru/pyguy"
    output_path = "/Users/ojiakuboss/Documents/TerraformGuru/pyguy/lambda_function.zip"
}

# create the Lambda function
resource "aws_lambda_function" "test_lambda" {
  # If the file is not in the current working directory you will need to include a 
  # path.module in the filename.
  filename      = "/Users/ojiakuboss/Documents/TerraformGuru/pyguy/lambda_function.zip"
  function_name = "lambda_function"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda_function.get_products"
  runtime       = "python3.9"
  depends_on    = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}

# create api gateway rest api
resource "aws_api_gateway_rest_api" "mbu" {
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = "mbu"
      version = "1.0"
    }
    paths = {
      "/path1" = {
        get = {
          x-amazon-apigateway-integration = {
            httpMethod           = "GET"
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "https://ip-ranges.amazonaws.com/ip-ranges.json"
          }
        }
      }
    }
  })

  name = "mbu"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}




