# Understanding User Access to Your Organization

## The Greatest Vulnerability
1. Leaking access keys -> if you allow for long-lived access keys, it is only a matter of time before bad actors gain access to your AWS resources. 
2. Compromised user credentials -> phishing attacks, social engineering, and brute force credential attacks can compromise your entire organization

| IAM Users | IAM Identity Center |
|:---------:|:-------------------:|
| Static access keys | Role with rotating access keys |
| Grants one user access to one account | Grants one user access to many accounts |
| One permission set per user | Many roles can be assumed by user |
| Federated Identity not supported | Designed for Federated Identity |

## AD Connector -> it leverages Microsoft AD
- use one's existing users and groups to grant permissions in AWS accounts
- easily integrated w/ AWS identity center (formerly AWS SSO)
- allows for a single source credential management but you can still adjust permissions from AWS

## Multi-Factor Authentication
- MFA can be enabled in IM Identity Center and enforced across our organization. So whenever a user wants to log in, they will first have to verify their identity on an MFA device that's set up when they enroll their user. Only by having the unique code that's sent to their MFA device are they allowed access to the AWS resources. Bad actors won't be able to advance past the login process because they don't have the MFA device

## Review User Activity 
there are still sophisticated attacks to hijack an ongoing session or advanced phishing attacks where bad actors can get a hold of those MFA codes, so we need to monitor and review user activity

When the log archive account is created, logs are stored there. No users have access to go in and manipulate the logs or delete the log storage. These are cloudtrail logs where we can 
- filter access activity by role name or user
- identify activities in a time range or search for specific activities
- monitor your cloudtrail logs with cloudwatch
- use guardduty for intelligent threat detection