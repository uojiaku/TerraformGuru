![alt text](challenge2.png)

![alt text](networking_challenge1.png)
Above, enhanced peering mode doesn't exist

![alt text](networking_challenge2.png)
Above, failover policy doesn't help with distributing load. latency policy wont help because if users have the same latency, they're still going to go to the same place. Multi-value answer policy doesn't help because users can cache IP addresses and as a result the load is not spreaded. CloudFront only serves up content and doesn't spread load. ALB can support sticky sessions and SSL
