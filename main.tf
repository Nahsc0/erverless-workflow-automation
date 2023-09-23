provider "aws" {
  region = "us-west-2"  # update this with your desired AWS region
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "/home/nasco/Desktop/Capstone/main.py"
  output_path = "/home/nasco/Desktop/Capstone/main.zip"
}

resource "aws_iam_role" "lambda_role" {  
  name = "lambda-lambdaRole-waf"  
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

resource "aws_lambda_function" "myLambda" {
  function_name = "MyLambdaFunction"
  filename      = "/home/nasco/Desktop/Capstone/main.zip"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  handler       = "main.lambda_handler"
  runtime       = "python3.8"
  role          = aws_iam_role.lambda_role.arn
}
