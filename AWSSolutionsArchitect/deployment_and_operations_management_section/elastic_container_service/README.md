# Elastic Container Service

- ECS and EKS are both managed highly available, highly scalable container platform.
1. ECS: AWS-specific platform that supports Docker containers
    - simpler to learn and use
    - leverages AWS services like Route53, ALB, and cloudwatch
    - TASKS: instances of containers that are run on underlying compute but more or less isolated.
    - limited extensibility
2. EKS: compatible with upstream k8s so its easy to lift and shift from other k8s.
    - considered more feature-rich and complex with a steep learning curve 
    - a hosted K8s platform that handles many things internally
    - PODS: containers collocated with one another and can have shared access to each other
    - extensible via a wide variety of 3rd party and community add-ons.

## ECS Launch Types
1. EC2 launch Type
- manual control for building out fleet
    - we can explicitly provision EC2 instances
- we are responsible for upgrading, patching, and care of EC2 pool
- we must handle cluster optimization
- more granular control over infrastructure

2. Fargate Launch Type
- no control for building out fleet
    - the control plane asked for resources and fargate automatically provisions
- Fargate provisions compute as needed.
- Fargate handles cluster optimization
- limited control, as infrastructure is automated