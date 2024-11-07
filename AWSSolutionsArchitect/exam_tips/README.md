# Exam Tips
https://docs.aws.amazon.com/whitepapers/latest/aws-overview/storage-services.html

https://docs.aws.amazon.com/whitepapers/latest/multi-tenant-saas-storage-strategies/multi-tenant-saas-storage-strategies.html

https://docs.aws.amazon.com/whitepapers/latest/scale-performance-elasticache/amazon-elasticache-overview.html

https://www.youtube.com/watch?v=SUWqDOnXeDw

https://www.youtube.com/watch?v=TJxC-B9Q9tQ

https://www.youtube.com/watch?v=_YYBdsuUq2M

https://www.youtube.com/watch?v=9wgaV70FeaM

https://docs.aws.amazon.com/whitepapers/latest/s3-optimizing-performance-best-practices/introduction.html

https://docs.aws.amazon.com/wellarchitected/latest/performance-efficiency-pillar/welcome.html


if question is about MySQL or PostgreSQL, we really want to choose Aurora over RDS because it has all the scalability and high availability features built in by design.
## Databases
|Databases |        |                              |                                  |
|:----------------:|:----------------------------:|:--------------------------------:| :-----------------: |
| EC2 Database | Relational Data | | |
| RDS | Relational Data | Low Operational Overhead | Mysql/PostgreSQL |
| Aurora | Relational Data | Low Operational Overhead | MySQL/PostgreSQL !!!! |
| DynamoDB | | | |
| DocumentDB | | | |
| Neptune |   | | |

## File Storage
| File Storage |        |                       |                           |
|:----------------:|:----------------------------:|:--------------------------------:|:-----------------:|
| S3 | Share Files || |
| EBS ||| |
| EFS | Share Files | Mount Directly to Targets | |
| FSx | Share Files | Mount Directly to Targets | Windows File Server |

## Others
Storage gateway -> storing objects on-prem and on S3
Glue -> cloud-native ETL
Redshift -> data warehouse analysis
Athena -> SQL query S3 objects
