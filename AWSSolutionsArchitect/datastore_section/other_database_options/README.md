# Other Database Options
https://aws.amazon.com/opensearch-service/
https://aws.amazon.com/blogs/aws/announcing-amazon-opensearch-service-which-supports-opensearch-10/

## Amazon Athena 
A SQL engine that has been overlaid on S3 using Presto. Designed to query raw query sitting inside S3 bucket. An easy way to analyze data in Amazon S3 using standard SQL.
- Use or convert data to Parquet format if possible for a big performance jump when querying data
- Similar in concept to Redshift Spectrum but both have different 
- Provides basic SQL querying capabilities. It does not support complex joins or advanced analytics functions typically found in traditional relational databases or data warehouses.
- Amazon Athena support these data formats: Apache Parquet, Apache ORC, JSON, etc. Athena does not support XML

use cases:

| Use Amazon Athena | use Reshift Spectrum |
|:-------------------------------------------------------:|:--------------------------------------------------------:|
| Data lives mostly on S3 w/o the need to perform joins with other data sources | Want to join S3 data with existing Redshift tables or create union products |

## Amazon Quantum Ledger Database (QLDB)
- Based on blockchain concepts
- Provides an immutable and transparent journal as a service w/o having to setup and maintain an entire blockchain framework
- Centralized design (as opposed to decentralized consensus-based design for common blockchain frameworks) allows for higher performance and scalability
- Append-only concept where each record contributes to the integrity of the chain.

Part of writing a record into the database produces a hash. A hash is a mathematical fingerprint of the data in that record. We use the hash as part of creating the hash for the next record. So hash from the previous record is used to the build the entry from the next record and so on.
If a record is changed it yields a different hash; because the chain is built on pre-existing hashes, the different hash will corrupt the entire chain. This is why ledger databases are immutable.

QLDB is great if all you need is a ledger. But if you need a full-blown blockchain framework

## Amazon Managed Blockchain
Fully managed blockchain framework supporting open source frameworks of Hyperledger Fabric and Ethereum
- Distributed consensus-based concept consisting of a network, members (other AWS accounts), nodes (instances) and potentially applications.
- Uses the Amazon QLDB ordering service to maintain complete history of all transactions

## Amazon Timestream Database
Fully managed database service specifically built for storing and analyzing time-series data
- Alternative to DynamoDB or Redshift and includes some built-in analytics like interpolation and smoothing
Use cases: industrial machinery, sensor networks, equipment telemetry

## Amazon OpenSearch (Elasticsearch)
- Not to be confused with ElastiCache
- Mostly a search engine but also a document store 
- Amazon opensearch service components are sometimes referred to as ELK stack:
Opensearch -> Search and Storage
LogStash (or CloudWatch, Firehose, Greengrass in IoT space) -> Intake
Kibana -> Analytics
It's primary a search engine, but inside it indexes the documents that serves up and stores them as documents in the form of some JSON. It's not an alternative to some other document database but useful as an analytics tool or for search