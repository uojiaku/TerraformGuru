# Scaling Containers on AWS

## Control and Complexity
- High control and high complexity vs low control and low complexity
    - EKS (on container instances) is an example of high control and high complexity. This allows us to use K8s and community support where we configure things ourselves.
    - ECS (on container instances) offers lesser control and lesser complexity. 
    - Fargate is offers even less control and complexity. And is managed service for scaling our containerized workloads
    - App Runner is an example of low control and low complexity. It allows us to basically provide AWS a containerized HTTP application and it basically does eveything else for us.

## EKS vs ECS
- both can be run on container instances which are basically EC2 instances in auto-scaling groups. 
- both can also run on Fargate, EC2, Outposts, Local Zones and AWS Wavelength (a 5G-optimized edge compute solution)

| EKS | ECS |
|:-------------:|:-----------:|
| supports k8s' mature ecosystem and community | aws-opinionated solution for running containers at scale |
| requires customization to power sagemaker, polly, batch and more | natively integrates with many AWS services |
| adding load balancers to container instances requires generalized abstractions | seamlessly integrates with ALBs or NLBs |

## Fargate -> a purpose-built compute layer for our containerized workloads
- handles scaling, security, and server management for ECS or EKS containerized workload compute layer
- integrtes with CloudWatch and Container Insights for monitoring applications
- pay for what we use, and scale quickly to meet demand
- great for request/response, batch, event handling, ML, and many other workloads

### ECS on EC2 Instances vs ECS on Fargate
- ECS on EC2 Instances: usually behind an autoscaling group. the EC2 instances will have containerized tasks running on them and as you increase the number of tasks we'll need to boot up new EC2 instances in our autoscaling group to accommodate the compute and memory needed to complete those tasks
- ECS on Fargate: when we run our containerized workloads on Fargate our compute layer scales per task. This is much faster than scaling EC2 instances and reduces operational overhead by allowing AWS to handle security and patches

## App Runner -> minimizes operational overhead for our HTTP applications
- the easiest way to scale containers in AWS
- designed exclusively for synchronous HTTP applications (if we have a containerized HTTP application that handles request/response style traffic, we can host it on App Runner)
- supplies compute and networking for container images, Python, Java, or Node.js projects
- supports public and private endpoints (so we can have an internal or a public facing application hosted on App Runner)
- scales to zero, which makes it great for proof-of-concept or side projects

## AWS Batch -> allows us to run thousands of containerized batch jobs
- plans, schedules, and executes our compute workloads
- dynamically provisions CPU or memory-optimized compute resources based on needs
- runs jobs using ECS, EKS, or Fargate
- reduces costs by optionally running our jobs using spot instances (we may not be able to run our batch jobs exactly on a schedule, depending on whether or not those spot instances are available.)
    - spot instances allow us to set a price we're willing to pay for instances during periods of low utilization on the AWS network.
    - during periods of high demand, our batch jobs will wait to run until those spots instances are available. 
        - similar with scaling EC2 instances, this is really only a valid option if its okay if our workloads start and stop or dont run exactly when we've scheduled them to run

## Summary
1. ECS is great for new solution development, but EKS may be a valid option for migrating an existing workload or using proprietary Kubernetes features
2. If we dont need super granular control over the types of instances that our ECS or EKS containers are running on, Fargate is almost always a more optimal and less operational overhead option for our compute layer
3. App Runner can get expensive at scale. This handles the compute layer and networking.