# DynamoDB Scaling
https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/bp-time-series.html

- DynamoDB scaling is divided into 2 dimensions: throughput (read and write capacity) and size(max item size is 400KB, but we can store as many 400KB itesm as we want to).

## DynamoDB Terminology
| Term | What |
|:-----:|:--------:|
| Partition | A physical space where DynamoDB data is stored (these are divided into 10GB chunks) |
| Partition Key | A unique identifier for each record; sometimes called a Hash key |
| Sort Key | In combination with a partition key; optional second part of a composite key that defines storage order; Sometimes called a Range Key |

## DynamoDB under the Hood
- dynamodb scales out by adding partitions
| Partition Calculations | |
|:-------------:|:----------------:|
| By Capacity | (Total RCU / 3000) + (Total WCU / 1000) |
| By Size | Total Size / 10GB |
| Total Partitions | Round Up for the MAX (By Capacity, By Size) |

### Example of 10GB Table, 2000 RCU and WCU
| Partition Calculations | |
| By Capacity | (2000 RCU / 3000) + (2000 WCU / 1000) = 2.66 |
| By Size | 10GB / 10GB = 1 |
| Total Partitions | MAX(2.66,1) = 2.66 Round Up = 3 Partitions |

- RCU = read capacity units
- WCU = write capacity units

- AWS allows some burst capacity.. it allows us to exceed some of that read and write capacity against a single partition if I'm not using that in those other partitions

- DynamoDB lands hashes on different partitions. Partition key doesn't get stored as the text value that you pass in, it gets translated into a hash value. 
    - With 1 partition all the data is going tp land on that same partition. If we increase our RCU or WCU provisioning or reach 10GB, 50% goes to partition 1 and 50% goes to partition 2.
    - This is based on the hash value or the partition keyv hash.
    - Its beneficial to have a partition key that has a degree of variability in it for the data because thats going to help us equally spread the load across the different partitions.

### Example of Partition key of date
With partition key = date and sort key = sensor_id. Since we get a lot of sensor readings every day, from a write perspective were going to be hitting that same partition because the date gets hashed out, its going to be the same. So we're probably going to be consuming all of our write capacity against that 1 partition pretty quickly, whereas partition 2 and 3 go unused.
- similarly when we go to read it, were going to be using a single partition and not distributing that load across all the partitions. This is known as a hot partition or a hot key issue.
- Alternatively we could choose to make the sensor_id as the partition key and then use date as the sort key. Now when those sensor_id's get hashed out chances are they're going to be landing on different partitions. we can also spread the read load across many partitions.

## Auto Scaling for DynamoDB
- It has the ability for us to specify autoscaling and when we reach a certain target utilization, we can scale up our provision capacity for read or write units
    - when we specify a certain provisioned limit, when we reach that limit, the DynamoDB configuration is going to trigger a cloudwatch notification. This is going to tell our application auto scaling process to go update the provision capacity on that DynamoDB table. 
        - we can also have an SNS notification go to us and let us know that that's happening. 

- using target tracking method to try to stay close to target utilization
- currently does not scale down if table's consumption drops to zero
- workaround 1: send request to the table until it auto scales down (it'll notice that the average load has dropped and scale down)
- workaround 2: manually reduce the max capacity to be the same as minimum capacity
- also supports global secondary indexes-think of them like a copy of the table

## On-Demand Scaling for DynamoDB
- alternative to autoscaling
- useful if you cant deal with scaling lag ot truly have no idea of the anticipated capacity requirements
- instantly allocates capacity as needed with no concept of provisioned capacity
- costs more than traditional provisioning and autoscaling

## DynamoDB Accelerator (DAX) -> in-memory cache that sits in front of your dynamoDB table and just provides caching in a format that's compatible with the dynamoDB API.
- allows for quicker response times from millisecond level to microsecond level

## DAX Use Cases
1. Good Uses of DAX
- requires fastest possible reads such as live auctions or securities trading
- read-intense scenarios where you want to offload the reads from dynamoDB
- repeated reads against a large set of dynamoDB data
2. Bad Uses of DAX
- write-intensive applications that don't have many reads
- applications where you use client caching methods
