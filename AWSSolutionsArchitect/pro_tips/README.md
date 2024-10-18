# Pro Tips

## Data Stores
- archiving and backup is a great first step when building a business case for using AWS data stores. Full migrations can be difficult and dangerous if unsure. Learning how to archive objects and files or backing up databases onto the cloud is a good start.
- Make sure we use the most cost-effective endpoints when connecting data stores to your VPC (S3 endpoints)
- Practice building secure S3 buckets and granting least-prvilege permissions
- Encrypt data at rest, always. S3 encrypts by default. Almost all AWS service offers encryption. Encrypt data in transit as well.

## Databases
- When calculating the cost of managed database services, factor in operational overhead (backups, patching, reliablity, scaling, etc).
- Familiarize yourself with NoSQL offerings i.e. DynamoDB ( the most performative database at scale on AWS)
- Aurora is the new standard for relational data on AWS (more scalable, performative, and all around a better option than RDS in most cases)
- Monitor performance and scaling activity with CloudWatch metrics; you can set alarms on CloudWatch metrics
