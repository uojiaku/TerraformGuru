# Internet Gateways

- Horizontally scaled, redundant and highly available component that allows communication betweem your VPC and the internet
- No availability risk or bandwidth constraints
- If your subnet is associated with a route to the internet, then it is a public subnet
- Supports IPv4 and IPv6

Internet Gateway fulfills two purposes:
1. Provides route table target for internet-bound traffic
2. Performs NAT for instances with public IP addresses
   - inside your VPC, all instances are known to each other by their private IP address. Their public IP address if assigned comes in only when they're trying to access the internet or when it's being accessed from the internet.
     - An instance that only has a private IP assigned regardless of whether it has a route to the internet gateway cannot get access to the internet
Internet Gateway does not perform NAT for instances with private IP's only

## Egress-only Internet Gateway
Exists only for one reason, IPv6.
Difference between Internet gateway and egress-only gateway is that the egress-only gateway is only outbound. Preventing inbound access to those IPv6 instances.

1. IPv6 addresses are globally unique and are therefore public by default
2. Provides outbound internet access for IPv6 addressed instances
3. Prevents inbound access to those IPv6 instances
4. Stateful-forwards traffic from instance to internet and then sends back the response
5. Must create a custom route for ::/0 to the Egress-only internet gateway
6. Use egress-only internet gateway instead of NAT for IPv6

## NAT Instance
1. EC2 instance from a special AWS-provided AMI
2. Translate traffic from many private IP instance to a single public IP and back
3. Doesn't allow public internet initiated connections into private instances
4. Not supported for IPv6 (use Egress-Only gateway)
5. NAT instance must live on a public subnet with route to Internet Gateway
6. Private instances in private subnet must have route to the NAT instance, usually the default route destination of 0.0.0.0/0

## NAT Gateway
1. Fully-managed NAT service that replaces need for NAT instance for EC2
2. Must be created in a Public subnet
3. Uses an Elastic IP for public IP for the life of the Gateway
4. Private instances in private subnet must have route to the NAT Gateway, usually the default route destination of 0.0.0.0/0
5. Created in specified AZ with redunancy in that zone
6. For multi-AZ redundancy, create NAT Gateways in each AZ with routes for private subnets to use the local Gateway
7. Up to 5Gps bandwidth that can scale up to 45 Gbps
8. Can't use a NAT Gateway to access VPC peering, VPN or Direct Connect, so be sure to include specific routes to those in your route table (remember: most specific route is selected first)

|  | Nat Gateway | NAT Instance |
|:-------------:|:--------------------------:|:-------------------------------:|
| Availability | Highly available within AZ | On your own |
| Bandwidth | Up to 45 Gbps | Depends on bandwidth of instance type |
| Maintenance | Managed by AWS | on your own |
| Performance | Optimized for NAT | Amazon Linux AMI configured to perform NAT |
| Public IP | Elastic IP that can not be detached | Elastic IP that can be detached |
| Security Groups | Cannot be associated with NAT gateway | Can use Security Groups |
| Bastion Server | Not Supported | Can be used as bastion server |

Overall, AWS recommends using a NAT Gateway over a NAT instance because it is scalable, highly available and fully managed.