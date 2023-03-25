## create policy - IAMReadOnlyAccess
resource "aws_iam_policy" "ec2_policy" {
    name = "IAMReadOnlyAccess"
    path = "/"
    description = "Policy to provide permission to EC2"
    policy = jsonencode({
    {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "iam:GenerateCredentialReport",
                "iam:GenerateServiceLastAccessedDetails",
                "iam:Get*",
                "iam:List*",
                "iam:SimulateCustomPolicy",
                "iam:SimulatePrincipalPolicy"
            ],
            "Resource": "*"
        }
      ]
    }
  })
}

## create role (trust policy) - name it DemoRoleforEC2
resource "aws_iam_role" "ec2_role" {
    name = "DemoRoleforEC2"
    assume_role_policy = jsonencode({
        "Version" = "2012-10-17",
        "Statement" = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Sid    = ""
                Principal = {
                    Service = "ec2.amazonaws.com"
                }
            },
        ]
    })
}

## attach role to policy
resource "aws_iam_policy_attachment" "ec2_policy_role" {
    name = "ec2_attachment"
    roles = [aws_iam_role.ec2_role.name]
    policy_arn = aws_iam_policy.ec2_policy.arn
}

## attach role to an instance profile
resource "aws_iam_instance_profile" "ec2_profile" {
    name = "ec2_profile"
    role = aws_iam_role.ec2_role.name
}

## attach the instance profile to the EC2 instance
resource "aws_instance" "myserv" {
    instance_type = "t2.micro"
    ami           = data.aws_ami.wo
}