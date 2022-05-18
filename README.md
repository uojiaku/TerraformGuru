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

#### Working With Resources Video:
Resources are the most important part of the Terraform language. Resource blocks describe infrastructure objects like virtual networks, compute instances, or components like DNS records.
##### Meta-Arguments
* depends_on -> specify hidden dependencies
* count -> create multiple resource instances according to a count
* for_each -> create multiple instances according to a map or a set of strings
* provider -> select a non-default provider configuration
* lifecycle -> set lifecycle customizations
* provisioner and connection -> take extra actions after resource creation
##### Operation Timeouts
> resource "aws_db_instance" "example" {
    
>> timeouts {

>>> *create = "60m"*

>>> *delete = "2h"*

>> } 

>}

* There are some resource types that provide special timeouts, nested block arguments that allow for customization of how long certain operations are allowed to take before they are deemed failed

##### How Configuration Is Applied
* create -> create resources that exist in the configuration but are not associated with a real infrastructure object in the state
* destroy -> destroy resources that exist in the state but no longer exist in the configuration
* update in-place -> update in-place resources whose arguments have changed
* destroy and re-create -> destroy and re-create resources whose arguments have changed, but which cannot be updated in-place due to remote API limitations

##### Resource Behavior
* Local-only resources -> specialized resource types that operate only within Terraform itself, calculating some results and saving those results in the state for future use.
> Examples: ssh keys, self-signed certs, random ids. 

#### Input Variables
##### Declaring and Input Variable
* the name of a variable can be any valid identifier except for:
> source, version, providers, count, for_each, lifecycle, depends_on, locals
* Example:
> variable "arbitrary_name" {

>> type = string

> }

##### Arguments and Constants
* optional arguments for variable declaration:
> default
> type
> description 
> validation
> sensitive

* type constraints -> allows you to restrict the type of value that will be accepted as the value for a variable. These are optional, but are recommended. They can serve as a helpful reminder for users of a module and return helpful error messages if the wrong type is used. such as: 
> string
> number
> bool

* type constructors -> allows you to specify complex types such as collections.
> list(type)
> set(type)
> map(type)
> object({attribute = type, ...})
> tuple([type, ...])

* Argument Examples -> we can add a **description** or **validation rules** to input variables
> input variable description
>> variable "image id" {

>>> type = string

>>> description = "The id of the machine image (AMI) to use for the server."

>> }

> Custom Validation Rules
>> variable "image_id" {

>>> type = string

>>> description = "The id of the machine image (AMI) to use for the server."

>>> validation {
        
>>>> condition = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"

>>>> error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."

>>> }

>> }

* Using the sensitive argument -> prevents terraform from showing it's value in the plan or apply output 
> variable "user_information" {

>> type = object({

>>> name = string
     
>>> address = string
 
>> })
 
>> sensitive = true

> }

* Using input variable values
> vars can be accessed with an expression such as var.{var_name} 
>> ex. ami = var.image_id

* How to assign variables to Root Modules Variables
> How to assign values:
>> in a terraform cloud workspace
>> individually, with the -var command like option
>>> terraform apply -var='image_id_list=["ami-abc123", "ami-def456"]' -var="instance_type=t2.micro"
>> in variable definitions like .tfvrs or .tfvars.json
>> as environment variables

> Calling the variable definition file from the command line:
>> terraform apply -var-file="testing.tfvars"

> Terraform automatically loads definition files if present:
>> Files named exactly terraform.tfvars or terraform.tfvars.json
>> Any files ending in .auto.tfvars or .auto.tfvars.json

* Environment Variables
> As a fallback for the other ways of defining variables, terraform will search the environment variables named TF_VAR_
>> ex. export TF_VAR_image_id=ami-abc123
>> terraform plan

* Precedence -> the order in which variables are loaded
> Environment variables
> terraform.tfvars
> terraform.tfvars.json
> *.auto.tfvars or *.auto.tfvars.json
> Any command-line options like -var and -var-file






