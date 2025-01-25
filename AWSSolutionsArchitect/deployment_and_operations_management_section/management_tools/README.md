# AWS Config
- allows us to access, audit, and evaluate configurations of our AWS resources
- very useful for configuration management as part of an ITIL program
- creates a baseline of various configuration settings and files and then can track variations against that baseline
- AWS config rules can check resources for certain desired conditions and if violations are found, the resource is flagged as "noncompliant"

## Example of AWS Config rules -> we can setup these rules that will continually monitor all the resources in AWS and let us know if anything is out of compliance.
1. Is Backup enabled on RDS?
2. Is CloudTrail enabled on the AWS account?
3. Are EBS volumes encrypted?

# AWS OpsWorks -> managed instance of Chef/Puppet 
- provide configuration management to deploy code, automate tasks, configure instances, perform upgrades, etc
- has 3 offerings: OpsWorks for Chef Automate, OpsWorks for Puppet Enterprise and OpsWorks Stacks
- OpsWorks for Chef Automate and Puppet Enterprise are fully managed implementation of each respective platform
- OpsWorks Stacks is an AWS creation uses an embedded Chef solo client installed on EC2 instances to run Chef recipes.
- OpsWorks Stacks support EC2 instances and on-prem servers as well with an agent

## AWS OpsWorks Stacks -> collections of resources needed to support a service or application
- layers represent different components of the application delivery architecture
    - EC2 instances, RDS instances, and ELBs are examples of Layers
    - we can put the Layers into a stack. 
- Stacks can be cloned -- but only within the same region
- OpsWorks is a global service. But when we create a stack, we must specify a region and that stack can only control resources in that region

