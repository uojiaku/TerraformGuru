# Network Migrations and Cutovers

## CIDR Reservations
- ensure your IP addresses will not overlap between VPC and on-prem
- VPCs support IPv4 netmasks range from /16 to /28
   - /16 = 255.255.0.0 = 65,536 addresses
   - /28 = 255.255.255.240 = 16 addresses
- Remember: 5 IPs are reserved in every VPC subnet that will take up addresses.
   - /28 = 255.255.255.240
         = 16 addresses (14 because first and last address is the network and broadcast address)
         = 14 "usable" minus 3 reserved address (route, dns, & ip reserved for future use) in a VPC = 11 available in VPC

## Network Migrations
- most organizations start with a VPN connection to AWS
- As usage grows, they might choose direct connect but keep the VPN as a backup
- transition from VPN to direct connect can be relatively seamless using BGP routing
- once direct connect is set-up, configure both VPN and direct connect within the same BGP prefix
- from the AWS side, the direct connect path is always preferred... but you need to sure the direct connect path is the preferred route from your network to AWS and not VPN (through BGP weighting or static routes)