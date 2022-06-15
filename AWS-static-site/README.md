# Creating a static website on AWS using S3
## with the IAM rule we have privileges to 

1. create bucket
> aws s3api create-bucket --bucket goat123 --acl public-read
2. create website from bucket
> aws s3 website s3://goat123 --index-document index.html
3. attach policy to bucket
> aws s3api put-bucket-policy --bucket goat123 --policy file://policy_s3.json
4. upload index.html file
> aws s3 cp build/index.html s3://goat123
5. curl the website or browse it online
> curl http://goat123.s3-website.us-east-1.amazonaws.com 