# Encryption

https://aws.amazon.com/kms/features/

Encryption at rest
- data is encrypted where it is stored such as on EBS, on S3, in an RDS database, or in an SQS queue waiting to be processed.

Encryption in transit
- data is encrypted as it flows through a network or process, such as SSL/TLS for HTTPS, or with IPSec for VPN connections

## Key Management Service (KMS)
1. Key storage, management and auditing
2. Tightly integrated into many AWS services like lambda, S3, EBS, EFS, DynamoDB, SQS, etc.
3. You can import your own keys or have KMS generate them
4. Control who manages and accesses keys via IAM users and roles
5. Audit use of keys via CloudTrail
6. Differs from secret manager as KMS is purpose-built for encryption key management
7. Validated by many compliance schemes (PCI DSS Level 1, FIPS 140-2 Level 3*)

## CloudHSM
if we need something more robust than KMS, then we can use CloudHSM.
- dedicated hardware device, single tenanted (meaning we dont share the device with anybody else)
- must be within a VPC and can access VPC Peering
- does not natively integrate with many AWS services like KMS, but rather requires custom application scripting
- offload SSL from web servers, act as an issuing CA, enable TDE for Oracle databases

| | "Classic" CloudHSM | Current Cloud HSM |
|:-----------:|:---------------------:|:--------------------:|
| Device | safeNet Luna SA | Proprietary   |
| Pricing | Upfront cost required ($5000) | No upfront cost, pay per hour |
| High Availability | Have to buy a second device | Clustered |
| FIPS 140-2 | Level 2 | Level 3 |

## CloudHSM vs KMS

|  | CloudHSM | AWS KMS |
|:-------------:|:-------------------:|:----------------------:|
| Tenancy | Single-Tenant HSM | Multi-Tenant AWS Service |
| Availability | Customer-managed durability and available | High available and durable key storage and management |
| Root of Trust | Customer managed root of trust | AWS managed root of trust |
| FIPS 140-2 | Level 3 | Level 3 |
| 3rd Part Support | Broad 3rd Party Support | Broad AWS Service Support |

## AWS Certificate Manager -> managed service that lets you provision, manage and deploy public or private SSL/TLS certificates
- directly integrated into many AWS services like CloudFront, ELB and API Gateway
- free public certificates to use with AWS services; no need to register via a 3rd party certificate authority
- ... but you cna import 3rd part certificates for use on AWS
- supports wildcard domains (*.domain.com) to cover all your subdomains
- managed certificate renewal (no embarrassing "certificate expired" messages for customers)
- can create a managed private certificate authority as well for internal or proprietary apps, services or devices