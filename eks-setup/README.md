# Learn Terraform - Provision an EKS Cluster

This repo is a companion repo to the [Provision an EKS Cluster learn guide](https://learn.hashicorp.com/terraform/kubernetes/provision-eks-cluster), containing
Terraform configuration files to provision an EKS cluster on AWS.


## for aws-auth issue
> terraform state rm 'module.eks.kubernetes_config_map.aws_auth[0]'
> rm .terraform/modules

## for Error: no EC2 IMDS role found, operation error ec2imds: GetMetadata, canceled, context deadline exceeded
> export AWS_ACCESS_KEY_ID=YOUR_ACCESS_KEY
> export AWS_SECRET_ACCESS_KEY=YOUR_SECRET_ACCESS_KEY

## after cluster is done installing, run this command
> aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)