# Data Store Concepts

## Data Persistence

Persistent data store -> data is durable and sticks around after reboots, restarts, or power cycles.
Ex. Glacier, RDS

Transient data store -> data is just temporarily stored and passed along to another process or persistent store.
Ex. SQS, SNS

Ephemeral data store -> data is lost when stopped.
Ex. EC2 Instance store, Memcached (within Elasticache)
Instance Store - locally attached ephermal storage. Provides fast disk I/O 

## IOPS vs Throughput
Input/Output Operations Per Second (IOPS) -> measure of how fast we can read/write to a device. Think of a fast nascar car.

Throughput -> Measure of how much data can be moved at one time. Think of a uhaul truck.

## Consistency Models (ACID/BASE)
### ACID
|                 |                      |
| ACID -> Atomic, Consistent, Isolated, Durable |
|:-----------------:|:---------------------------------:|
| Atomic | Transactions are "all or nothing" |
| Consistent | Transactions must be valid |
| Isolated | Transactions can't mess with one another |
| Durable | Completed transaction must stick around |

A half-transaction can't get written to the database. ACID models dont scale very well. As relational databases with ACID have row locking and contention to slow down the database
### BASE
|                             |                               |
| BASE -> Base Availability, Soft-state, Eventual Consistency |
|:-----------------:|:---------------------------------------:|
| Base Availability | values availability even if stale |
| Soft-state | might not be instantly consistent across stores |
| Eventual Consistency | will achieve consistency at some point |