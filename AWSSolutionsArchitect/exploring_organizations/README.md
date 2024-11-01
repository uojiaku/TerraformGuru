# Exploring Organizations

https://docs.aws.amazon.com/whitepapers/latest/organizing-your-aws-environment/organizing-your-aws-environment.html

- AWS accounts are containers for your cloud resources
- AWS organizations centralizes managment of multiple accounts using a managment account

## Anatomy of a Organization

1. Management Account -> account provisions and managed the organization (recommended that you don't have any workloads running in the management account)
2. Member Account(s) -> accounts that contain your AWS resources and workloads

## Organizational Units (OUs) -> Groups of accounts that share access patterns or serve a similar application or service
- this way you can apply policies to an organizational unit and all of the accounts in that OU will have those policies applied to them

## Why Multiple Accounts?
- it's a coarse filter for access to cloud resources. Only users who have access to an account can possibly take actions on the resources in that account
- we can group workloads based on business purpose and ownership
- apply least privilege security to each environment
- restrict access to sensitive data 
- limit the scope of impact for security events involving outside access
- manage costs by consolidating billing across your accounts

## Control Tower -> allows you to automate your multi-account management 
- includes an automated approach to managing best practices
- centralize and automate guardrails across your organization. You can apply account wide service control policies or AWS config rules all from a single point in your organization
- provides an organization dashboard to improve visibility 
- when we launch an account using control tower, it will land in our landing zone and it will have all the recommended guardrails applied to it automatically. It will also have permissions that Control tower needs to provision the account

1. When we create a landing zone, a few accounts will be created for you within the core OU:
   - log archive -> where cloudtrail logs will be aggregated
   - audit account -> where there will be some cross-account audit roles automatically provisioned so auditors can have read access to certain portions of the AWS environment
2. We can create one or more custom OUs where our provisioned accounts will live. Any time we create an account it will fall under this custom OU.
3. When we create accounts, control tower will automatically apply blueprints and guardrails across those accounts and this is what is considered our account baseline. Anytime we provision a new account, this baseline will also be applied

### Keys Terms to Understand 
- Landing Zone -> what you provision when you start using Control Tower. Your landing zone is a recommended, customizable starting point
- guardrail -> a high-level rule governed by service control policies or AWS config rules. these are customizable by OU or by account
- baseline -> the combination of blueprints (cloudformation stacks) and guardrails applied to a member account.
- blueprints -> cloudformation stacks that give control tower access to the managed account and they apply those guardrails to a member account

