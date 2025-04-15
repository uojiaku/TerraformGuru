# AWS Service Catalog -> framework allowing administrators to create pre-defined products and landscapes for their users
- granular control over which users have access to which offerings.
    - so we can set up groups that say this particular set of end-users has access to these products and not these other products
- makes use of adopted IAM roles so users don't need underlying service access. 
    - so we don't have to manage the individual IAM rights and roles for individual users. I can deploy a service on Service Catalog and then they can be a push-button to deploy it and have access to it. now we dont have to outfit that user with all those other roles that might not be needed on a day-to-day basis
- allows end users to be self-sufficient while upholding enterprise standards for deployments
- based on CloudFormation templates
- administrators can version and remove products. Existing running product versions will not be shutdown

## AWS Service Catalog Constraints
- used to control how those products can get consumed.
  
| Type | What | Why |
|:--------------------:|:---------------------------:|:---------------------:|
| Launch Constraint | IAM role that Service Catalog assumes when an end-user launches a product | Without a launch constraint, the end-user must have all permissions needed within their own IAM credentials |
| Notification Constraint | Specifies the Amazon SNS topic to receive notifcations about stack events | Can get notifications when products are launched or have problems |
| Template Constraint | One or more rules that narrow allowable values an end-user can select | Adjust product attributes based on choices a user makes. (Example: only allow certain instances types for DEV environment.) |

- in a multi-account environment you can share a service portfolio with another account. That master account, you can share the catalog and the recipient administrator in those other accounts can then import that portfolio. and then that portfolio gets kept in sync between the shared portfolio. Products, launch contraints, template constraints are all inherited from the shared portfolio. 
    - The recipient administrator can also add to that shared portfolio by creating a local portfolio, and they can add additional launch constraints or template constraints, to maybe make the criteria for launching this more restrictive
    - the products always stay in sync, if we deploy something in our shared portfolio, it automatically cascades down to those portfolios that have been imported in other accounts
    - IAM groups and users and roles are not inherited. The recipient administrators must add users and groups and roles to the portfolio so that those users in that account can access it
    - by default, if we just share a catalog and import a catalog into the other account, the launch role and that's the IAM role that launches the service on behalf of the user requesting it, is inherited from the shared portfolio. 
        - by default, its going to try to launch those resources in that original master account
            - as a local administrator(admin of that sub-account), we can override that and create a local portfolio and then create a new launch constraint that uses a localized launch role. 
            - launch constraints are associated with a product in the portfolio and not at the portfolio level. so I can have an individual role to define for each and every product
