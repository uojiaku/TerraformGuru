# Exam Tips
https://docs.aws.amazon.com/whitepapers/latest/web-application-hosting-best-practices/welcome.html?did=wp_card&trk=wp_card

https://docs.aws.amazon.com/whitepapers/latest/scale-performance-elasticache/scale-performance-elasticache.html?did=wp_card&trk=wp_card

https://www.youtube.com/watch?v=w95murBkYmU

https://www.youtube.com/watch?v=dPdac4LL884

https://www.youtube.com/watch?v=9TwkMMogojY

https://docs.aws.amazon.com/wellarchitected/latest/framework/welcome.html

https://docs.aws.amazon.com/whitepapers/latest/microservices-on-aws/microservices-on-aws.html

- Auto Scaling Groups:
    1. know the different scaling options and policies
    2. understand the difference and limitations between horizontal and vertical scaling
    3. know what a cool down period is and how it might impact our responsiveness to demand
- Kinesis:
    1. exam is likely to be restricted to the Data Stream use cases for Kinesis such as Data Streams and Firehose
    2. understand shard concept and how partition keys and sequences enabled shards to manage data flow

- DynamoDB Auto Scaling:
    1. know the new and old terminology and concept of a partition, partition key and sort key in the context of DynamoDB
    2. understand how DynamoDB calculates total partitions and allocates RCU and WCU across available partitions
    3. conceptually know how data is stored across partitions

- CloudFront Part 2:
    1. know that both static and dynamic content is supported
    2. understand possible origins and how multiple origins can be used together with Behaviors
    3. know invalidation methods, zone apex and geo-restriction options.

- SNS:
    1. understand a loosely coupled architecture and benefits it brings
    2. know the different types of subscription endpoints supported

- SQS:
    1. know the difference between Standard and FIFO queues
    2. know the difference between a pub/sub (SNS) and message queueing (SQS) architecture

- Lambda:
    1. know what "serverless" is in concept and how Lambda can facilitate such an architecture
    2. know the languages supported by Lambda

- SWF:
    1. understand the difference and functions of a worker and a decider
    2. best suited for human-enabled workflows like order fulfillment or procedural requests.

- Elastic MapReduce:
    1. understand the parts of a Hadoop landscape at a high level
    2. know what a cluster is and what Steps are
    3. understand the roles of a master node, core nodes, and task nodes

- Step Functions:
    1. managed workflow and orchestration platform considered preferred for modern development over AWS Simple Workflow Service
    2. supports tasks, sequential steps, parallel steps, branching, timers

- AWS Batch:
    1. ideal for use cases where a routine activity must be performed at a specific interval or time of day
    2. behind the scenes, EC2 instances are provisioned as workers to perform the batch activities then terminated when done

- Serverless Application Model:
    1. open-source framework created to make serverless application development and deployment more efficient
    2. SAM CLI translates specific SAM YAML into CloudFormation scripts which is then used to deploy on AWS
    3. serverless application repository contains lots of apps we can use as examples or elements of our own apps
    4. AWS SAM and the "Serverless Framework" are different things

- Auto Scaling:
    1. be familiar with the positioning and different purposes of EC2 auto scaling vs Application auto scaling vs AWS auto scaling
    2. know the different scaling options and policies
    3. understand the difference and limitations between horizontal and vertical scaling
    4. know what a cool down period is and how it might impact our responsiveness to demand

    | AWS Whitepapers | Required |
    |:------:|:-----:|
    | re:Invent Videos | Optional but Recommended |