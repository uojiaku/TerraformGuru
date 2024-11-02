# Sharing Resources Across Accounts

## Resource Access Manager -> centralized resource sharing service designed to help you share your resources across multiple AWS accounts.
1. share resources with principals across many accounts
2. share with individual accounts or OUs within your organizations
    - when resources are shared, they appear as though they exist in each account they're shared with. 
3. Resources are still owned by the sharing account

- resource sharing must be enabled by your organization
- regional resources can only be shared within the same region

## How it works
1. Choose the resource you would like to share
2. Apply a managed policy to your resource share (defines the permissions, the actions, that the principals will take on your resources)
3. Define principles for your resources share (define which accounts and which roles in those accounts can share your resources)
4. Send share invitation to principal account(s) and upon accepting those invitations in Resource Access Manager, those accounts will then have access to your resource

## Common Use Cases
1. Foundational infrastructure: share VPC infrastructure across many accounts in your organizations.
  - ex. insteading of netwokring VPCs together we could share VPC across many accounts
2. Certificate authorities: centrally manage your private certificate authorities, and share to reduce cost and complexity.
3. App Mesh Networking: app mesh allows networking between disparate compute infrastructure and share a mesh with RAM
4. Aurora clusters: share Aurora or RDS clusters across accounts and allow cross-account cloning