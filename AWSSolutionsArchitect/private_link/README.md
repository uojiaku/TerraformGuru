# Private Link

A secure way to connect VPC endpoints
1. Establish private connections to services outside of your VPC without having the fully peer or connect those VPCs together
2. Highly available and scalable
3. Traffic does not traverse the public internet
4. Control the API endpoints, sites, and services reachable from your VPC
5. Connects to endpoints within the same regions as your VPC 

## Compatible Endpoints
Many AWS services have private endpoints available, so we can use private link to connect to these endpoints within the same AWS account or across multiple AWS accounts
We can use privatelink to connect to applications like the ones behind network load balancers or services that you provisioned from the AWS marketplace

## Common use cases
1. Marketplace solutions -> Marketplace solutions often provide APIs, which you can connect with using privatelink
2. Endpoint services -> endpoint services owned by your organization in a separate VPC can leverage privatelink without having to establish network connectivity between your VPCs
3. Peering alternative -> when you want limited, secure connection to resources in another VPC
4. third-party applications -> provide secure and scalable access with simplified networking rules

## Summary
1. Allows you to treat services outside of your VPC as though they were inside your VPC for the purposes of networking. Allows you to establish networking from a private subnet securely to a given set of endpoints 
2. Connect directly to any native service endpoints (such as API Gateway, DynamoDB, S3) that exist within the same region of the VPC you are trying to connect
3. A great solution for marketplace solution endpoints that exist in the same region as your VPC