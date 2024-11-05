## Data Stores
![alt text](challenge2.png)

## Networking
![alt text](networking_challenge1.png)
Above, enhanced peering mode doesn't exist

![alt text](networking_challenge2.png)
Above, failover policy doesn't help with distributing load. latency policy wont help because if users have the same latency, they're still going to go to the same place. Multi-value answer policy doesn't help because users can cache IP addresses and as a result the load is not spreaded. CloudFront only serves up content and doesn't spread load. ALB can support sticky sessions and SSL

- Quiz questions/answers:

1. VPC CIDR block size is fixed at /56. Subnet CIDR block size is fixed at /64.

2. To allow VPC instances to resolve using on-prem DNS we have to configure a DHCP Option Set to issue our on-prem DNS IP to VPC clients

3. Direct Connect requires 802.1Q VLAN support

4. A network load balancer with an EIP (Elastic IP) will allow our AWS application to leverage static IP addresses that can be allowlisted by the customer firewall. Network load balancers support static IP addresses; you can also assign one elastic IP address per subnet enabled for the load balancer. https://docs.aws.amazon.com/elasticloadbalancing/latest/network/introduction.html

## Security

https://docs.aws.amazon.com/pdfs/whitepapers/latest/organizing-your-aws-environment/organizing-your-aws-environment.pdf#organizing-your-aws-environment

![alt text](security_challenge1.png)
Above, 
- a publishing account allows you to leverage your IT organization as a shared service to provide standardization
- if you want to keep regulatory and compliance requirements localized as much as possible, there is generally a very strong logging component.
- compliance account structure does not exist


![alt text](security_challenge1b.png)
Above,
 is how it might look in practice, we have consolidated security, the root account (holding company that serves as the shared service)
 - we created a logging account and attached it to each one of the business units.

![alt text](security_challenge1b.png)

