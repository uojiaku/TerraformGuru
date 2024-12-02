# Business Continuity Exam Tips

https://docs.aws.amazon.com/pdfs/prescriptive-guidance/latest/backup-recovery/backup-recovery.pdf

https://docs.aws.amazon.com/whitepapers/latest/migrating-databases-to-amazon-aurora/migrating-databases-to-amazon-aurora.html

https://docs.aws.amazon.com/pdfs/wellarchitected/latest/reliability-pillar/wellarchitected-reliability-pillar.pdf

https://www.youtube.com/watch?v=xc_PZ5OPXcc

https://www.youtube.com/watch?v=RMrfzR4zyM4

https://www.youtube.com/watch?v=a7EMou07hRc

- General Concepts:
    1. know the difference between business continuity, disaster recovery, and service levels
    2. know the difference between high availability and fault tolerance
    3. understand the inter-relationships and how AWS uses the terms
    4. know the difference between RTO and RPO
    5. know the four general types of DR architectures and trade-offs of each

- Storage Options:
    1. understand the HA capabilities and limitations of AWS storage options
    2. know when to use each storage option to achieve the required level of recovery capability
    3. understand RAID and the potential benefits and limitations

- Compute Options:
    1. understand why horizontal scaling is preferred from an HA perspective
    2. know that compute resources are finite in an AZ and know how to guarantee their availability
    3. understand how Auto Scaling and ELB can contribute to HA

- Database Options:
    1. know the HA attributes of the various database services
    2. understand the different HA approaches and risks for memcached and redis
    3. know which RDS options require manual failover and which are automatic

- Network Options:
    1. know which networking components are not redundant across AZs and how to architect for them to be redundant
    2. understand the capabilities of Route53 and Elastic IP in context of HA

| AWS Whitepapers | Required |
|:---------------:|:--------:|
| re:Invent Videos | Optional but recommended |