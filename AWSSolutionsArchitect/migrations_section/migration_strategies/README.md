# migration strategies

| Migration | Description | Example |
|:----------------------:|:--------------------:|:-----------------:|
| Re-Host | "Lift and Shift"; simply move assets with no change | Move on-prem MySQL database to EC2 Instance |
| Re-Platform | "Lift and Reshape"; Move assets but change underlying platform | Migrate on-prem MySQL database to RDS MySQL |
| Re-Purchase | "Drop and Shop"; Abandon existing and purchase new. | Migrate legacy on-prem CRM system to salesforce.com |
| Rearchitect | Redesign application in a cloud-native manner | Create a server-less version of legacy application |
| Retire | Get rid of applications which are not needed | End-of-life the label printing app because no-one uses it anymore |
| Retain | "Do nothing option"; Decide to reevaluate at a future date | "Good news Servers, you'll live to see another day." |

| Migration Strategy | Effort (Time and Cost) | Opportunity to Optimize |
|:----:|:---:|:---:|
| Re-Host | ** | * |
| Re-Platform | **** | *** |
| Re-Purchase | *** | * |
| Rearchitect | ***** | ***** |
|             |       |       |
| Retain      | *     |       |