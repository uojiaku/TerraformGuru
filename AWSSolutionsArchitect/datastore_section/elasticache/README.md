# Elasticache
Fully managed implementations of two popular in-memory data stores (Redis and memcached)
- Push-button scalability for memory, writes and reads
- In memory key/value store-not persistent in the traditional sense.. so they are really fast because they are not tied to disk I/O, elasticache is rather than DynamoDB. The trade-off is persistence. If you using redis, you have the option to backup and restore and there are some ways to create persistent data. But never think of Redis as a persistent data store like DynamoDB or RDS.
- Elasticache is billed by node size and hours of use
- Elasticache for Memcached does not offer native encryption of data at rest. For a managed caching solution with encryption at rest, we can use Elasticache for Redis.

## Use Cases
| Use | Benefit |
|:-------------------:|:----------------------------------------------------------------------------------------:|
| Web Session Store | In cases w/ load-balanced web servers, store web session information in Redis so if a server is lost, the session info is not lost and another web server can pick-up. |
| Database Caching | Use Memcache in front of AWS RDS to cache popular queries to offload work from RDS and return results faster to users. |
| Leaderboards | Use Redis to provide a live leaderboard for millions of users of your mobile app. |
| Streaming Data Dashboards | Provide a landing spot for streaming sensor data on the factory floor, providing live real-time dashboard displays. |

## Memcached vs. Redis

| Memcached | Redis |
|:------------------------------:|:------------------------------------------:|
| Simple, no-frills, straight-forward | You need encryption |
| You need to scale out and in as demand changes | You need HIPAA compliance |
| You need to run multiple CPU cores and threads | Support for clustering |
| You need to cache objects (o.e. like database queries) | You need complex data types |
| | You need high-availability(replication) |
| | Pub/Sub capability |
| | Geospatial indexing |
| | Backup and Restore |

A cache is a cache, don't use a cache to do the job of an RDS database or S3