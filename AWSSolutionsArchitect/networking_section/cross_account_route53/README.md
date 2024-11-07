# Cross-Account Route 53

by default we have NS records and SOA record, they help resolve the appropriate name server internal to AWS whenever somebody wants to navigate to that address.

## Directing to a Subdomain
1. Create a hosted zone in the account associated with your subdomain. 
2. Copy the NS records from the newly created hosted zone (because when you create hosted zone you'll be given new NS records and a new SOA record)
3. Access the parent DNS hosted zone in the appropriate account
4. Create a new NS record set in the parent domain's hosted zone (this new NS record set will help resolve the subdomain)
5. Paste the NS reocrds from the child domain's hosted zone 

In this way we can delegate control of those subdomains to their associated accounts while still managing the parent domain from a more secure parent DNS account

## Summary
1. Hosted Zone = collection of records
  - You can create a hosted zone for each subdomain, as long as you provide the appropriate NS records to the parent domain hosted zone, the control of those subdomains can be delegated across accounts.
2. Multiple accounts help with Security and Visibility
  - Separating accounts by staging environment can allow you to fine-tune access and monitoring and then delegate control to the appropriate teams.