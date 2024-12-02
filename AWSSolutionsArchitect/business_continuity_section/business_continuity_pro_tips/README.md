# Business Continuity Pro Tips

- Failure Mode and Effects Analysis (FMEA)
    1. A systematic process to examine:
        - what could go wrong
        - what impact it might have
        - what is the likelihood of it occurring
        - what is our ability to detect and react
    2. Formula is Severity * Probability * Detection = Risk Priority Number or Severity * Probability + Detection = Risk Priority Number

## Step 1 - Round up Possible Failures
- failure mode: we look at all our critical processes and look at what are all the things that could happen that can create problems for us 
- current controls: any sort of ways that we have to detect those problems before they create difficulty for a customer or ourselves

|    | Failure Mode | Cause | Current Controls |
|:-------:|:------:|:-------:|:-------:|
| Invoicing | Pricing Unavailable | Retail price incorrect in ERP system | Master data maintenance audit report |
| Invoicing | Pricing Incorrect | Retail price not assigned in ERP system | None |
| Invoicing | Slow to build Invoice | Invoicing System is slow | None |
| Invoicing | Unable to Build Invoice | Invoicing System is offline | Uptime monitor |

## Step 2 - Assign Scores
- once we gone through and decided what are all the things that cna go wrong and what the causes are, we can go back and rate their impact and their likelihood and our ability to detect them and react to them. 

|     | Failure mode | Customer Impact | Likelihood | Detect and React | Risk Priority Number |
|:-------:|:------:|:-------:|:-------:|:-------:|:-------:|
| Invoicing | Pricing Unavailable | 7 | 3 | 2 | 42 |
| Invoicing | Pricing Incorrect | 8 | 3 | 9 | 216 |
| Invoicing | Slow to build Invoice | 5 | 2 | 9 | 90 |
| Invoicing | Unable to Build Invoice | 8 | 3 | 2 | 48 |

- From the table below, a higher number is worse. We work from the highest number down to try to implement mitigation plans or additional redundancies or additional processes around that potential problem so we can try to keep it from happening or at least reduce that RPN number

## FMEA Across Disaster Categories

|     | Category | Customer Impact | Likelihood | Detect and React | Risk Priority Number |
|:-------:|:------:|:-------:|:-------:|:-------:|:-------:|
| eCommerce system | Hardware Failure | 9 | 5 | 2 | 90 |
| eCommerce system | Deployment Failure | 9 | 1 | 2 | 18 |
| eCommerce system | Load Induced | 5 | 5 | 2 | 50 |
| eCommerce system | Data Induced | 6 | 1 | 6 | 36 |
| eCommerce system | Credential Expiration | 7 | 6 | 7 | 294 |
| eCommerce system | Dependency | 7 | 7 | 2 | 98 |
| eCommerce system | Infrastructure | 8 | 5 | 9 | 360 |
| eCommerce system | Identifier Exhaustion | 2 | 2 | 2 | 

- with credential expiration, maybe SSL TLS cert expires. We can make use of AWS Certificate Manager to manage our certs, because certificate manager's going to automatically renew those and not get us into that situation. by that we would lower the likelihood of our certificate expiring.