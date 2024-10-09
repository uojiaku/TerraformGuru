# Redis

## can handle  
   * complex data types: sorted sets, hashes, bitmaps, etc
   * large datasets

## Features include:
  * backup & restore -> can also be used for persisting data
  * publish & subscribe -> allows clients to subscribe to channels & receive notifications
     - feature is useful for 
       1. real-time messaging app
       2. event-driven architectures
       3. broadcasting messages to multiple clients
  * transactions
  * geospatial support
  * append-only files (AOF) for creating a warm cache -> allows to persistently log every write operation that modifies that dataset
    - set via cluster's parameter groups, only available for specific nodes
  * global datastore -> allows you to replicate data across mulitple regions 
  * snapshots that can be used to persist data

## Redis Architecture
  * Replication groups
    - automatic failovers of a failed primary cluster to a read replica

## Redis Supports
  * Replication nodes using replication groups
  * Partitioning the data across shards through cluster mode enabled -> spreads your workload and thus reduced access issues during high demand
    1. single node with no replication 
       - can add/remove replicas (horizontal scaling)
       - can change node type (vertical scaling)
    2. cluster mode disabled with replication
       - can add/remove replicas (horizontal scaling)
       - can change node type (vertical scaling)
       - optional with at least one replica
    3. cluster mode enabled with replication and data partioning
       - can add/remove replicas (horizontal scaling)
       - can change node type (vertical scaling)
       - multi-AZ is required

## Redis Configurations
  * Single node with no replication -> just a single node setup
  * Cluster mode disabled with replication -> single shard with a primary node along with replica node(s). Single shard is great if you have a small dataset.
    - 0-5 replica nodes
    - replication groups
      - replica nodes form replication groups
      - replica nodes can span AZs
      - multi-AZ replicas support automatic failover -> great for both high availability and disaster recovery
  * Cluster mode enabled with replication and data partioning -> Great if you have a larger dataset or you need to distribute and store your data across several shards. Each shard has its own primary node and it own replica nodes 
    - 0-5 replica nodes
    - replication groups
      - replica nodes form replication groups
      - replica nodes can span AZs
      - multi-AZ replicas support automatic failover
    - you can have up to 500 shards
      - shard 1 for letters A-M
      - shard 2 for letters N-Z
    Shards (paritioning) helps you spread your workload over a larger number of endpoints
   