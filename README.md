# Terraform
Terraform Infrastructure Deployment for AWS VPC, EC2, and EKS

## Description

### Terraform module 
A Terraform module is a collection of standard configuration files in a dedicated directory. Terraform modules encapsulate groups of resources dedicated to one task, reducing the amount of code you have to develop for similar infrastructure components.

This Terraform project automates the provisioning of AWS infrastructure components, including:

* VPC (Virtual Private Cloud): A private network in AWS for isolating and securing resources.
* EC2 (Elastic Compute Cloud): A virtual server that can run applications and services in the cloud.
* EKS (Elastic Kubernetes Service): A managed Kubernetes service for running containerized applications.
The aim of this project is to streamline the process of setting up a secure, scalable, and highly available cloud infrastructure using Terraform as Infrastructure-as-Code (IaC).

## Features:

Creates a custom VPC with subnets across multiple availability zones, route table, nat gateway, internet gateway.
Sets up an EC2 instance within the VPC and security group.
Configures EKS cluster to run Kubernetes workloads.

## Execution Steps
### Prerequisites
Before running the Terraform code, ensure the following:

* AWS Account: You need an active AWS account with sufficient privileges to create resources like VPC, EC2, and EKS.
   * Create IAM user in aws and attach the policy to create resources.

* Terraform: Terraform should be installed on your local machine. If not, follow the Terraform installation guide to set it up.
```
   subdo apt-get update
   sudo apt-get install terraform
```

* AWS CLI: AWS Command Line Interface (CLI) should be installed and configured with the necessary credentials. 
   * Install aws cli 
   ```
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        unzip awscliv2.zip
        sudo ./aws/install
   ```
   * To configure AWS CLI, run aws configure and provide necessary credentials or you can create profile and provide necessary credentials.
   ``` 
        aws configure --profile <profile-name> # add the profile name in variables.tfvars file
   ```
* Create bucket and add bucket name into the backend.tf file to store terraform state files.
* Create dynamodb table to ebable state lock and add the name into backend.tf file, Terraform will lock your state for all operations that could write state. This prevents others from acquiring the lock and potentially corrupting your state. [ If you don't want to use state lock you can skip the step]

* Clone the repository
```
git clone <url>
```

*   if you want to create infra for dev environment go to dev directory, for test environment go to test directory and for prod environment go to prod directory and run following commands:
* Run the following command to initialize the Terraform configuration and download the necessary provider plugins
 
```
    terraform init
```
* To see what changes Terraform will make to your infrastructure, run the following command
```
    terraform plan
```
* To create the resources run:
```
    terraform apply --auto-approve
```
* EKS: To interact with the EKS cluster, configure your kubectl to point to the newly created cluster by running:
```
    aws eks --region <region> update-kubeconfig --name <eks-cluster-name>
```
* Cleanup: To destroy all resources created by Terraform, run:
```
    terraform destroy
```