## Infrasture as Code -> adding version control to our cloud infrastructure
- CloudFormation templates define infrastructure in JSON or YAML
- CloudFormation can be abstracted by frameworks like AWS CDK, SAM or Terraform
- CloudFormation Stacks create, update, or delete a set of related resources
- StackSets allow us to deploy and update a set of resources in multiple accounts or regions

### CloudFormation StackSets
1. For an example if we have 3 AWS accounts (admin account, dev account, test account). Instead of logging into each account and manually creating each config rule where the settings can drift a apart overtime because of the operational overhead. 
    - We can use StackSets to define these rules in a single account and deploy the rules to multiple accounts and multiple regions in those accounts. For this to be done, CloudFormation in the admin account has to be able to assume an execution role in the member accounts. When it assumes this role, it can execute the CloudFormation stack and deploy identical rules across all of these accounts and regions.
        - whenever we make a change to our StackSet, it will automatically deploy to all of these accounts and regions 
- Also an integral part for managing multiple accounts with Control Tower.
Control Tower automatically provisions a Core OU(organizational unit) and allows us to provision accounts in Custom OU(organizational unit). All these accounts have a baseline applied to them.
- The Control Tower baseline gives Control Tower the ability to aggregate logs and make changes within its member accounts. It also applies config guardrails and it does all of this using StackSets
- When we provision a multiple account environment using Control Tower, we're also going to be setup with AWS Service Catalog

### AWS Service Catalog -> sharing approved templates across our organization
- create and govern a curated list of AWS products
- allows users to provision resources without full access to AWS services
- portfolios can contain many products (portfolios are a collection of products)
- share portfolios with specific accounts or across our organization

1. Difference beteen service catalog and stacksets is that StackSets are deployed to accounts that we desire and that deployment is sort of pushed. With Service Catalog were empowering the users of that account to optionally provision approved architecture 

#### Example Service Catalog
if we have an admin account and multiple member accounts. and if we want to setup a standardized pipeline for microservices. these accounts may need 1 or more of these pipelines. we can define our pipelines as code and create a portfolio containing this product in service catalog. We can share the portfolio with accounts A and B. As needed these accounts can provision this pipeline. Perhaps, account B only needs one instance of this pipeline, but account A can choose to provision multiple pipelines for multiple microservices.
1. service catalog will allow us to have a single source of truth for our approved architecture, and we can give permissions for users in these member accounts to provision portfolios without necessarily giving them free reign to provision the underlying services

# Summary
1. we can control infra and app code together 
2. for standard infrastructure we want to keep consistent across many accounts, StackSets enable us to create, update, and destroy infra across many accounts at once.
3. create portfolios of approved products: use service catalog to define preconfigured AWS resources for users to provision across our organization without granting full permissions to the underlying services.