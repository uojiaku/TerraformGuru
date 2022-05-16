# TerraformGuru

### Using Terraform to Manage Applications and Infrastructure

#### Terraform CLI Video:
* terraform version => find the terraform version
* terraform -chdir=<path_to/tf> <subcommand> => switch the working directory
* terraform plan => create an execution plan
* terraform plan -out <plan_name> => output a deployment plan
* terraform plan -destroy => output a destroy plan
* terraform init => initialize the directory
* terraform apply => apply changes
* terraform apply <plan_name> => apply a specific plan
* terraform apply -target=<resource name> => only apply changes to a targeted resource
* terraform apply -var my_variable=<variable> => pass a variable via the command line
* terraform destroy => destroy the managed infrastructure
* terraform providers => get provider info used in configuration
##### Initialize the terraform directory that contains the main.tf file
* terraform init or terraform init -upgrade
##### Create the plan that terraform will execute with main.tf or output a deployment plan
* terraform plan or terraform plan -out <nameofplan>
##### Apply the terraform plan 
* terraform apply

#### Configuration Language Video:

> resource “aws_vpc” “main” {
>>	cidr_block = var.base_cidr_block
>> }

> *BLOCK TYPE* *"BLOCK LABEL”* *“BLOCK LABEL”*  {
>>	*IDENTIFIER* = *EXPRESSION*
>> }

* Language consists of blocks, arguments, and expressions. Blocks are containers for objects like resources. 
* File extension - .tf and .tf.json
* Text encoding - plain text files (UTF-8), Unix-style line endings(LF), Windows-style line endings(CRLF)
* Modules are a collection of .tf and/or .tf.json files in a directory


