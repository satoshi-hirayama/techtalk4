# Techtalk #4

Terraform scripts and Ansible roles to create Amazon ECS and ECR resources like following.

```
+- AWS VPC
   +- ELB
   +- AZ1
   |  +- Public Subnet
   |  |  +- Bastion/Proxy with EIP (Ubuntu)
   |  +- Private Subnet
   |     +- ECS cluster instance (Ubuntu)
   +- AZ2 (Empty subnets create for ELB)
   |  +- Public Subnet
   |  +- Private Subnet
   +- ECR
```

## Requirements

* Terraform 0.7.13
* Ansible 2.2.0.0

## Usage

### Setup

Copy `terraform/terraform.tfvars.sample` to `terraform/terraform.tfvars` and `terraform_ecr/terraform.tfvars.sample` to `terraform_ecr/terraform.tfvars`, then set your aws credentials.

Set name prefix for instance, repository, buckets and other resources.

* Files
  * terraform/variables.tf
  * terraform_ecr/variables.tf
* Variables
  * base_name
  * base_name_hyphen
  * base_name_camel

Create two ssh keys with following name and write public keys to `terraform/variables.tf`.

* Key name
  * ec2_bastion_instance_ssh_key
  * ec2_app_instance_ssh_key
* Variables
  * ec2_bastion_instance_ssh_public_key
  * ec2_app_instance_ssh_public_key

Put private keys to `terraform` directory.

Region is set to 'ap-northeast-1 (Tokyo)' by default. To set other region, rewrite `variables.tf` file.

### Create ECR resources

```
$ cd terraform_ecr
$ terraform plan
$ terraform apply
```

### Push docker image to ECR

Follow steps on your ECR console. Sample dockerfile is in `docker/nginx`.

### Create ECS resources

Setup ECS service to use ECR.

* Files
  * terraform/ecs_service.json
* Variables
  * `image` is created ECR repository uri.

Now you can create ECS resources.

```
$ cd terraform
$ terraform plan
$ terraform apply
```

### Provision ECS resources

Setup host IP address.

* Files
  * provisioning/ssh_config
     * Bastion IP address is allocated EIP.
     * ECS IP address is VPC internal address of ECS Cluster instance.

Then provide.

```
$ cd provisioning
$ ansible-playbook -i production.ini production.yml --extra-vars "proxy_ip=<YOUR BASTION IP, NOT EIP, BUT VPC INTERNAL IP>"
```
