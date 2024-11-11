# Migrating Applications

## Workload Migrations
- one way AWS migration paradigm has shifted is that there's a general shift away from server migratgion (also called lift and shift migration) and a shift toward workload migration (breaking applications into their component parts and migrating individual workloads)

1. Batch jobs or Containerized Workload on-prem -> AWS Batch or Fargate
2. Tomcat application on-prem -> Elastic Beanstalk or Lightsail
3. Cronjobs, message handling microservices, decoupling queues, event handling workloads on-prem -> Event Driven or Serverless Architecture

## Migration Hub -> a central hub for migration planning and tracking
- leverages application discovery service to analyze and group servers (groups servers into applications and helps determin which servers need to be migrated in order to migrate an entire application to AWS)
- gives instance recommendations to help you right-size your workloads (after analyzing your on-prem servers migration hub will host instance recommendations to help right size EC2 workloads)
- provides situational migration strategy best practice advice
- keeps track of lift-and-shift and refactor-first migration progress with n intuitive dashboard

## Application Discovery Service -> a way to audit on-prem environment and figure out which servers are involved in a given application
1. first step in provisioning application discovery service is to install the application discovery service agent on each of your on-prem servers. While an on-prem application is still serving production, this agent works behind the scenes to track traffic between servers and can help you determine which servers are involved in a given application.
2. then it sends this traffic data encrypted over the internet to the Application Discovery Service dashboard in the Migration Hub where it creates a map of your applications that you can use to visually understand which servers are involved in your application
3. then you can start to address questions like is it appropriate to lift and shift this application directly into EC2 instances or should we consider a re-platform of one or more of the servers involved in this application (ex. taking a PostgreSQL server and potentially hosting it on Amazon Aurora instead of putting it on an EC2 instance)

## Application Migration Service -> lifting servers to the AWS cloud
- Once we determine which servers need to be lifted and shifted to the AWS cloud, we can then use Application Migration Service(MGN) 
1. Migrate windows and linux servers to the AWS cloud
2. Source servers can be on-prem, on AWS, or on other cloud providers
3. Allows for test environment and cutover with minimal interruption
4. MGN agent helps you right-size EC2 instances
5. free to use (only pay for the resources you provision)

- To lift-and-shift servers from on-prem to AWS EC2, we install MGN agent on each of the on-prem servers and once a connection is established over VPN or Direct Connect, the MGN will begin to continuously replicate the block storage of all those servers over to the staging environment where minimally sized EC2 instances will be provisioned, 
    - and you can connect to these instances to make sure they are configured correctly and ready for production. Once we determine that it is time for a cutover, MGN can provision the right-sized EC2 instances in the production VPC and you can divert traffic to your application accordingly with minimal interruption.

- MGN is a good solution for replicating across regions. We can migrate an application to a different region. We can create a warm standby of our application or have an application that is closer to our end users.

## Bringing AWS to Your Data Center
- we can bring AWS functionality to our data center. We can run EKS or ECS anywhere on bare metal. 
    - We can use AWS outposts which are physical servers or racks that we can order from AWS that comes preconfigured to run some AWS services. We can EC2, S3, and RDS instances on AWS outposts
    - Snowball edge, a device you can order that is capable of using EKS anywhere or EC2 to process data with import and export jobs. 
        - If you have no internet connection, you can bring a snowball edge device to help collect and transform your data on site. Then later send the device back to have that data uploaded to S3
