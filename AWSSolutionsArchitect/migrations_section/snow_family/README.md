# Snow Family
- evolution of AWS Import/Export process
- move massive amounts of data to and from AWS
- Data transfer as fast or as slow as you're willing to pay a common carrier (UPS, DHL, FedEx, etc)
- AWS sends us this device and then we load data onto it, it is encrypted at rest
- It is encrypted in transit

| AWS Import/Export | Ship an external hard drive to AWS. Someone at AWS Plugs it in and copies our data to S3. |
|:-------------------:|:-------------------------------------:|
| AWS Snowball | Ruggedized NAS in a box AWS ships to you. You copy over up to 80TB of your data and ship it back to AWS. They copy the data over to S3 |
| AWS Snowball Edge | Same as Snowball, but with onboard Lambda and clustering (has clustering and local processing power so it acts as a portable AWS. If you need to capture and process data in a very remote location) |
| AWS Snowmobile | A literal shipping container full of storage (up to 100PB) and a truck to transport it. |