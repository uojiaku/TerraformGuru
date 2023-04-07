# Terraform tasks 
## task 1
### launch 2 instances - Amazon Linux, t2.micro, w/o keypair, using launch-wizard-1 security group(allows http from 0.0.0.0/0), storage = 1 8GB gp2, include the user data script
<!-- variable "user_data" {
  description = "The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead."
  type        = string
  default     = <<-EOT
 #!/bin/bash
# Use this for your user data (script from top to bottom)
# install httpd (Linux 2 version)
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>Hello world from $(hostname -f) </h1>" > /var/www/html/index.html
EOT
} -->

### ALB works with http and https traffic
### create an application load balancer (ALB), internet-facing scheme, ip address type: ipv4, network mapping (map to us-east-1a, us-east-1b, us-east-1c, us-east-1d. us-east-1e. us-east-1f), assign a new security group that only allows http traffic, route the traffic from http port 80 to a target group, create a target group: target type = instances, protocol http on port 80, protocol version = HTTP1, health check protocol = http, health check path = /, register targets = both newly created ec2 instances on port 80

## task 2
### update the ec2 instances to only allow inbound http traffic from the ALB security group by changing the 0.0.0.0/0 to the ALB security group
### add the listener rule to the ALB /error rule that retuens a 404 with a response message "this is error"

## task 3
### create a network load balancer (NLB), internet-facing scheme, ip address type: ipv4, network mapping (map to us-east-1a, us-east-1b, us-east-1c, us-east-1d. us-east-1e. us-east-1f), route the traffic from tcp port 80 to a target group, (create a target group: target type = instances, health check protocol = http, health check path = /, advanced health check settings -> healthy threshold = 2, timeout = 2 seconds, interval = 5, status code 200 or 200-399)

## task 4 
### edit the attributes of a target group, create sticky session -> stickiness, stickiness type = load balancer generated cookie, stickiness duration = 1 day

## task 5 
### enable crosszone loadbalancing 

## task 6
### add listener to ALB, protocol -> HTTPS 443, defaults actions -> forward to target group (consisting of two instances), Security policy -> default policy?, default SSL/TLS certificate -> 

## task 7
### create an autoscaling group, create a launch template -> 

## task 8
### create scaling policies, policy type -> target tracking scaling -> metric type: average CPU utilization with target value: 40, autoscaling group: desired capacity: 1, minimum capacity: 1, maximum capacity: 3

## task 9
### create Amazon RDS, database creation method -> standard create, engine options -> MySQL version MySQL 8.0.28, templates -> Free tier, Availability and durability -> Single DB instance, credentials settings -> master username: admin - master password: 12345, instance configuration -> burstable classes: db.t2.micro, storage -> gp2 10GB - storage autoscaling: enabled - maximum storage threshold: 1000, connectivity -> don't connect to an EC2 compute resource - db subnet group: default - public access: yes - database port: 3306, database authentication -> password authentication, monitoring: disabled, Database options -> initial database name: mydb, backup -> enable automated backups - backup retention period: 7 days - backup window: no preference, Log exports -> no logs, Maintenance -> enable auto minor version upgrade, Deletion protection -> enable deletion protection

## task 10
### create RDS Aurora

## task 11 redis - good for HA, memcached good for sharding
### ElasticCache, create redis cluster, cluster mode: disabled, location: AWS cloud, Multi-AZ: disabled, Auto-failover: disabled, engine version: 6.2, port 6379, parameter groups: default.redis6.x, node type: cache.t2.micro, number of replicas: 0, maintenance -> auto upgrade minor verions: enable

## task 12 Create Route53 A Record

## task 13 Create Route53 Policies - simple, weighted, latency ; Create Route53 health check

## task 14 - Create s3 bucket, create s3 bucket policy

## task 15 - create s3 website with versioning

## task 16 - create s3 replication, add lifecycle rule

## task 17 - create s3 event notification

## task 18 - create S3 Cors Rule

## task 19 - create s3 access log
