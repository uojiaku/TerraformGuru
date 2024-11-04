# Exam Tips

https://docs.aws.amazon.com/whitepapers/latest/organizing-your-aws-environment/organizing-your-aws-environment.html

https://docs.aws.amazon.com/whitepapers/latest/aws-best-practices-ddos-resiliency/aws-best-practices-ddos-resiliency.html

https://www.youtube.com/watch?v=gjrcoK8T3To

https://www.youtube.com/watch?v=YQsK4MtsELU

https://www.youtube.com/watch?v=tzJmE_Jlas0

https://www.youtube.com/watch?v=71fD8Oenwxc

https://www.youtube.com/watch?v=fxo67UeeN1A

https://docs.aws.amazon.com/pdfs/wellarchitected/latest/security-pillar/wellarchitected-security-pillar.pdf

## Multi-Account Management:
- know the different models and best practices for cross-account management of security
- know how roles and trusts are used to create cross-account relationships and authorizations

## Network Controls and Security Groups:
- know the differences and capabilities of NACLs and SGs.
- NACLs are stateless
- Get some hands-on with NACLs and SGs to reinforce your knowledge
- remember the ephemerals

## AWS Directory Services:
- understand the types of directory services offer by AWS - especially AD Connector and Simple AD.
- understand use-cases for each type of Directory Service
- be familiar with how much on-prem active directory implementation might connect to AWS and what functions that might enable

## Credential and Access Management:
- know IAM and its components 
- know how to read and write IAM policies in JSON
- understand identity brokers, federation, and SSO
- know options and steps for temporary authorization

## Encryption:
- know differences between AWS KMS and CloudHSM and use cases
- the test will likely be restricted to the "classic" CloudHSM (classic CloudHSM has upfront payment, and you have to buy 2 of them to get high availability)
- understand AWS Certificate Manager and how it integrates with other AWS services

## DDoS attacks:
- understand what they are and some best practices to limit your exposure
- know some options to mitigate them using AWS services

## IDS/IPS:
- understand the difference between IDS and IPS
- know what AWS services can help with each
- understand the differences between cloudwatch and cloudtrail

## Service Catalog:
- know that it allows users to deploy assets through inheriting rights
- understanding how Service Catalog can work in a multi-account scenario

## for further study read through the AWS whitepapers is required, and watching the re:Invent videos is optional but recommended.