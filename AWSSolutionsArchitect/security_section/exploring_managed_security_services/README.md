# Exploring Managed Security Services

## Security Hub -> single panel view for security insights
if in a multi-account environment or a complicated single account environment.
- integrates with inspector, guardduty, firewall manager, and Macie to deliver security insights
- receives metric and logs from these services and generates prioritized recommendations based on AWS best practices
- helps integrate security findings in multi-account environments
- receives logs and metrics from multiple accounts and give you individualized recommendations
- can integrate with 3rd party security services

## Network Firewall vs. WAF

### Network Firewall
With a network firewall, it's assumed that traffic is reaching your application through a VPC. And the network firewall sits outside your VPC and filters traffic coming into and leaving your VPC.
 - this traffic can come from many different sources, transit gateways, direction connection, VPN, or internet gateway
 - the network firewall can filter out traffic from specified IP addresses, and you can make custom rules based on patterns found in incoming packets. 

### WAF
WAF is meant to protect a much broader spectrum of AWS endpoints. You can filter traffic to and from application load balancers, CloudFront, API gateway, AppSync, and more. If you're building highly distributed or serverless applications that are being accessed from the internet, WAF is a good choice for your application.

## Shield for DDoS
Shield is the primary service for defending against distributed denial of service (DDoS) attacks. Shield also comes with a shield advanced feature which you can turn on for specific workloads. 
| Shield | Shield Advanced |
|:------------------------:|:---------------------------:|
| Protection against known infrastructure attacks (layers 3 and 4) | Protection from more advanced DDoS attacks (including application layer) |
| Applied to all AWS services when activated | Specify resources to protect (ELBs, CloudFront distributions, etc) |
| Use standard AWS support for DDoS assistance | Dedicated 24x7 access to DDoS experts |
| Limited visibility on attacks | Detailed logs can help you analyze attacks |

Anytime you have production applications exposed to the public internet, having AWS shield protecting those applications is a must have.

## Firewall Manager -> a way to manage your firewall settings and configurations across your organization
- standardize firewall rules across your account and organization
- deploy security tools (such as firewalls or AWS shield) at scale, spanning many VPCs and accounts
- integrates with Security groups, WAF, Shield, and Network firewall, as well as 3rd party tools
- provide audit details to generate security insights with security hub 

## GuardDuty for intelligent detection
GuardDuty uses machine learning to intelligently detect threats and nefarious actions all throughout your AWS ecosystem. It leverages a variety of data sources, including AWS cloudtrail management events, AWS cloudtrail event logs, VPC flow logs, and DNS logs.
- As it inspects your logs it will generate security alerts and recommendations. These can be used to directly alert users, send insights and metrics to AWS security hub or trigger events in Amazon Event Bridge and take automatic remediation actions.

## Summary
1. Security Hub: provides a single-pane console where you can monitor and take action on security events from many services across your organization
2. Firewall manager: integrates with Network Firewall, WAF, and Shield to centrally manage rules and configurations for your security services.
3. GuardDuty: uses intelligent threat detection to alert you of malicious activity across your organization, it can also respond to specified security events automatically with EventBridge