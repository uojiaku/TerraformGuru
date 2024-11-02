# Network Controls and Security Groups

## Security Groups
1. Virtual firewalls for individual assets (EC2, RDS, AWS Workspaces, etc)
2. Controls inbound and outbound traffic for TCP, UDP, ICMP or custom protocols
3. work based on port or port ranges
4. Inbound rules are by source IP, subnet, or other security group
5. Outbound rules are by destination IP, subnet, or other security group

## Network Access Control Lists

1. Additional layer of security for VPC that acts as a firewall
2. Apply to entire subnets rather than individual assets(security groups apply to individual assets)
3. Default NACL allows all inbound and outbound traffic
4. NACLs are stateless - meaning outbound traffic simply obeys outbound rules - no connection is maintained
5. Can duplicate or further restrict access along with security groups
6. remember ephermeral ports for outbound if you need them

## Why use Security Groups & NACLs?
- NACLs provide a backup method of security if you accidentally change your security group to be too permissive
- covers the entire subnet so if users create new instances and fail to assign a proper security group are still protected
- part of a multi-layer least privilege concept to explicitly allow and deny