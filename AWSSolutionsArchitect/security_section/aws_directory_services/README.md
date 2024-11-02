# AWS Directory Services

## Types of Directory Services Offered

| Directory Service Option | Description | Best for.. |
|:------------------------:|:------------------------------------------------------------------------:|:----------------------------------:|
| AWS Cloud Directory | Cloud-native directory to share and control access to hierarchical data between applications | Cloud applications that need hierarchical data with complex relationships |
| Amazon Cognito | Sign-up and sign-in functionality that scales to millions of users and federated to public social media services | Develop consumer apps or SaaS |
| AWS Directory Service for Microsoft Active Directory | AWS-managed full Microsoft AD (standard or enterprise) running on Windows Server 2012 R2 | Enterprises that want hosted Microsoft AD or you need LDAP for Linux apps |
| AD Connector | Allows on-premises users to log into AWS services with their existing AD credentials. Also allows EC2 instances to join AD domain | Single sign-on for on-prem employees and for adding EC2 instances to the domain |
| Simple AD | Low scale, low cost AD implementation based on Samba | Simple user directory, or you need LDAP compatibility |

## AD Connector vs. Simple AD
| AD Connector | Simple AD |
|:-------------------:|:--------------------:|
| Must have existing AD | Stand-alone AD based on Samba |
| Existing AD users can access AWS assets via IAM roles | Supports user accounts, groups, group policies, and domains |
| Support MFA via existing RADIUS-based MFA infrastructure | Kerberos-based SSO|
| | MFA not supported |
| | No Trust Relationships |