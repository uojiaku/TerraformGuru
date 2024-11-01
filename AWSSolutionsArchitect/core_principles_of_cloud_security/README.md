# Core Principle of Cloud Security

## 1. Principle of Least Privilege
Give users and services nothing more than those privileges necessary to perform their intended functions and only when they need them.
- never have long lasting access keys
- all permission granted to users and services will be temporary i.e. leveraging IAM roles and privileges granted will be limited to only allow very specific actions to those users and services.

## Facets of Identity Security
1. Identity -> who are you? 
- IAM user or role
- root account user
- temporary security credentials

2. Authentication -> prove you are who you say (any way of validating an identity is true)
- Multi-factor authentication
- client-side SSL certificate

3. Authorization -> Are you allowed to do this? (giving those authenticated identities access to services and actions in your AWS env)
- IAM policies

4. Trust -> Do other entities I trust say they trust you? (way of validating your identity against 3rd party entities that are trusted)
- Cross-account access
- SAML-based federation
- web identity federation

## Authentication and Authorization

A Typical Security Flow
Identity's overall goal is to access to the AWS service provider
1. Identity could be a human user, application or IoT device. The identity will reach out to the identity provider which contains an identity broker.
2. The identity broker reaches out to an identity store and authenticates this identity
   - The identity broker could also reach out to a trusted 3rd party identity provider to validate the identity of the user. i.e. Cognito or Google
3. When the user is authenticated the identity store will provide a key or token which will authorize that identity to take specific actions in the service provider.

## Network Security

Bad actors can send malicious packets to your VPC or attempt DDOS attacks on your web applications

Plan for things to go wrong
- passwords will be stolen, can be minimized with MFA
- Exposed resources will be accessed, understanding how to secure your VPCs and public endpoints is integral to minimizing this risk.
- Static access keys will be leaked, avoid providing these.
- How can we limit the blast radius of security events?
  1. preemptively monitor for malicious behavior
  2. isolate resources in multiple accounts
- How do we prevent exposing sensitive data?
  1. encrypt data at rest and in transit