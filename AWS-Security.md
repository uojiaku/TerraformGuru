# AWS-Security - Security 101
## Security Basics Video
### CIA Model (The Triad)
#### Confidentiality -> Privacy, where you want to keep confidential but expose to third parties as needed. 
1. IAM
2. MFA 
3. Bucket Policies
4. Security Groups
5. Access control lists in our VPC
Involves maintaining consistency, accuracy and trustworthiness of data over it's entire lifecycle. We dont want the data to change in transit. 
and you have to ensure that data cannot be altered by unauthorized people.
> good examples of ensuring confidentiality: 
>> data encryptions -> encrypting data at rest and data in transit. 
>>> Data can be things like user IDs and passwords.
>> Two-factor auth -> which is used in IAM (identity access management) 
>> Biometric verifications
#### Integrity -> file permissions, user access controls, version control, checksums (where you download a piece of software, there will be a checksum next to it. Once you download it you can check the hash of that software to the checksum, and if they match you know the data is integral)
1. Certicate Managers -> Amazon will issue you with an SSL certificate (a good way of keeping your data with good integrity)
2. IAM -> keep people away who don't have the privileges
3. Bucket policies -> keep people away who don't have access to data
4. Version control
5. MFA -> when you're trying to delete things inside S3. you can require that someone provides an MFA token before an object is deleted
#### Availability - keeping systems available. you don't want any hardware failure, 
redundancy over everything. 
You want your disks to rated, high availability clusters, mulitple availbility zones, mulitple regions. You want to design for failure as well
1. Auto-scaling
2. Multiple availability zones
3. Multiple regions
4. Route 53 with healthchecks -> to help detect failure and automatically fail over

### AAA Model 
#### Authentication
1. IAM
#### Authorization
1. Policies -> permissions to use certain services. ex. can you provision ec2 instances, can you create new buckets
#### Accounting -> What are you doing on the AWS platform
1. CloudTrail -> Audit Trail
when CloudTrail is turned on every single API call you make within AWS is recorded and logged

### Non-repudiation (can't deny) -> you can't deny that you did something
