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

#### Declaring Output Variables -> return values
* They have many use cases:
1. A child module can use them to expose a subset of resource attributes to the parent module.
2. A root module can use them to print values in the CLI.
3. Root module outputs can be accessed by other configurations via the terraform_remote_state data.
4. Each output value that is exported by a module must be declared using an output block. The label after the output keyword must be a valid identifier. Within a root module this name is displayed to the user. In a child module, it can be used to access the output's value. The value argument takes an expression whose output is to be returned to the user.
* Optional Arguments for variable declaration
>> description
>>> output "instance_ip_addr" {

>>>> value = aws_instance.server.private_ip

>>>> description = "The private IP address of the main server instance."

>>> }

>> sensitive
>>> output "out" {

>>>> value = "xyz"

>>>> sensitive = true

>>> }

>> depends_on

>>> variable "instance_ip_addr" {
 
>>>> value = aws_instance.server.private_ip

>>>> description = "The private IP address of the main server instance"

>>>> depends_on = [

>>>> // Security group rule must be created before this IP address could 

>>>> // actually be used, otherwise the services will be unreachable.

>>>> aws_security_group_rule.local_access,

>>>> ]

>>> }

#### Declaring Local Variables

* Local Values are like a function's temporary local variables
1. allow you to assign a name to an expression
2. allow you to use the variable multiple times within a module without repeating it

> locals {

 >> service_name = "forum"

 >> owner = "community team"

> }

> resource "aws_instance" "example" {

>> type = string

>> tags = local.common_tags

> }

#### Modules -> a container for multiple resources
they can consist of .tf files as well as .tf.json files in a directory

* 3 Module Types:
1. Root Module -> you need at least one root module.consists of the resources defined in the .tf files in the main working directory
2. Child Modules -> modules that are called by the root module. they can be called multiple times within the same configuration. Multiple configurations can use the same child module
3. Public Modules -> modules loaded from a public or private registry. 

Calling a Child Module

> module "servers" {

>> source = "./app-cluster"

>> servers = 5

> }

* Module Arguments -> 4 argument types
1. Source argument -> required for all modules
2. Version argument -> recommended for modules from a registry
3. Input variable arguments
4. Meta-arguments -> ex. for_each, depends_on, count, providers

* Accessing Module Output Values

1. Child modules can declare output values to selectively export values which are accessible by the calling module.
2. if the module exported an output value named instance_ids, then the calling module can reference that result using the expression module.servers.instance_ids.. see example below:

> resource "aws_elb" "example" {

>> instances = "module.servers.instance_ids"

> }

* Transferring Resource State
We can use the **terraform state mv** command to inform terraform that the child module block has been moved to a different module. Because? when you split code into other child modules, or when moving resource blocks between modules you can use Terraform to see the new location of the module block as an entirely different resource.
> when passing resource addresses:
1. Resources within the child modules must be prefixed with module."module_name"
2. If a module is called with count or for_each, it must be prefixed with module."module_name"["index"] instead.

* Taint Resources Within A Module
command **terraform taint module."module_name"."resource_name"**
1. It is not possible to taint an entire module. Instead each resource in a module must be tainted separately













