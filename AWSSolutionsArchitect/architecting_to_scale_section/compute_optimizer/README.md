# Compute Optimizer -> machine learning tool to help you optimize your compute resources. It analyzes resources and gives you recommendations.
- can help increase the cost efficiency of our compute resources by reconfiguring over-provisioned resources
- can help your performance by rightsizing under-provisioned resources
- can activate this in a single account or across your organization

## How it Works
1. you give compute optimizer complete access to your compute resources and the cloudwatch metrics that our compute resources produce. 
2. compute optimizer tracks our performance and utilization over time by analyzing our resources and cloudwatch metrics
3. after analysis it will produce a set of configuration recommendations and make it available to us
4. we can go into compute resources to change configurations to optimize cost and performance

## Compatible Resources
- Compatible for EC2, ECS on Fargate, Lambda, AutoScaling Groups and EBS
- rightsizing EC2 instances, get recommendations on instance types, and optimize your auto scaling groups
- get recommendations on EBS volume types and sizes
- optimize task size and container size configurations for ECS on Fargate
- optimize CPU or memory allocation for your Lambda functions
