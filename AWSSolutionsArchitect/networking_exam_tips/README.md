# Networking Exam Tips

https://docs.aws.amazon.com/pdfs/whitepapers/latest/aws-vpc-connectivity-options/aws-vpc-connectivity-options.pdf

https://docs.aws.amazon.com/vpc/latest/userguide/security.html

https://www.youtube.com/watch?v=KGKrVO9xlqI

https://www.youtube.com/watch?v=8gc2DgBqo9U

https://www.youtube.com/watch?v=z0FBGIT1Ub4

https://aws.amazon.com/blogs/networking-and-content-delivery/tag/mpls/

## VPCs in general:
  1. Know the pros/cons of each on-prem to AWS connection mode
  2. Know the functions of the different VPC components (Customer Gateway, Virtual Private Gateway)
  3. Know that Direct Connect is not inherently redundant, so know how to architect a network that is (VPN, secondary direct connect).
  4. Know what is meant by "stateless", "stateful", "connectionless", and "connection-based" in terms of IP protocols
  5. Know what ephemeral ports are and why they might need to be NACLs or Security Groups.

## Routing:
  1. Understanding BGP and how to use weighting to shift network traffic
  2. Know how routes in a route table are prioritized (most specific routes are first)
  3. What other routing protocols does AWS support (none... only BGP) So our only choice is static routes

## VPC Peering:
  1. CIDR ranges cannot overlap
  2. After VPC owner accepts a peering request, routes must be added to respective route tables
  3. Transitive peering is not supported, but mesh or hub-and-spoke architectures are ... with proper NACLs and routes
  4. A transit VPC is supported

## Internet Gateway:
  1. Difference between a NAT Instance and NAT Gateway
  2. Internet Gateway is horizontally scaled, redundant, with no bandwidth constraints
  3. NATs do have bandwidth constraints but..
  4. VPCs can have multiple NATs across AZs and subnets for scale - so long as routes are defined properly
  5. Use Egress-Only Gateway for IPv6

## Route 53:
  1. Understand different types of routing policies and use cases
  2. Know the weighted routing formula
  3. Route 53 is a global service

## CloudFront:
  1. Understnad what must happen to use a custome domain with CloudFront
  2. Understand what SNI enables and the necessary alternative

## Elastic Load Balancer:
  1. Know the three different types of Load Balancers and at which OSI layer they work
  2. Understand which major features each deliver (protocol, SNI, sticky sessions)
  3. Know what sticky sessions are and when they come into play

  | AWS Whitepapers | Required |
  |:-------------:|:----------------------:|
  |re:Invent Videos | Optional but Recommended |