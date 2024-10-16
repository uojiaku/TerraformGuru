## AWS CLI Profiles
> aws configure --profile awsgoat                                
AWS Access Key ID [None]: AKIAQVYLKBIAV4AVOMOE
AWS Secret Access Key [None]: HGbAMXlDqJ6xD5mrtIMvY3/HK9Rja9Cf7NBwlYqL
Default region name [us-east-1]: 
Default output format [None]: 

> aws sns create-topic --name example-topic-one --profile awsgoat
{
    "TopicArn": "arn:aws:sns:us-east-1:046731495937:example-topic-one"
}

> aws sns list-topics --profile awsgoat
{
    "Topics": [
        {
            "TopicArn": "arn:aws:sns:us-east-1:046731495937:example-topic-one"
        }
    ] 
}
> aws sts get-caller-identity

> aws sts get-caller-identity --profile awsgoat

> export AWS_PROFILE=awsgoat

# fetch running ec2 instances
aws ec2 describe-instances

# launch ec2 instance
aws ec2 run-instances --image-id ami-0fff1b9a61dec8a5f --instance-type t2.micro 