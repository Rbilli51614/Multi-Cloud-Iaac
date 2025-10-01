# Multi-Cloud Infrastructure as Code (Terraform AWS + GCP VPC-EC2-Load Balancer)

## Topics
terraform, aws, gcp, iac, devops, sre, multicloud

## Badges
[![Terraform](https://img.shields.io/badge/Terraform-1.7.5-blue?logo=terraform&logoColor=white)](https://www.terraform.io/)  
[![AWS](https://img.shields.io/badge/AWS-Cloud-orange?logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)  
[![GCP](https://img.shields.io/badge/GCP-Cloud-blue?logo=google-cloud&logoColor=white)](https://cloud.google.com/)  
[![MIT License](https://img.shields.io/badge/License-MIT-green)](https://opensource.org/licenses/MIT)

## Overview
This project deploys AWS and GCP infrastructure using Terraform. It is designed for multi-cloud, DevOps, and SRE use cases.

## Terraform Stacks
- **AWS Stack:** `stacks/aws`
- **GCP Stack:** `stacks/gcp`

## Usage
Use the included Makefile to initialize, apply, or destroy stacks:

```bash
# AWS
make aws-init
make aws-apply
make aws-destroy

# GCP
make gcp-init
make gcp-apply
make gcp-destroy

## Folder Structure

```multi-cloud-iac/
├─ README.md
├─ LICENSE
├─ .gitignore
├─ Makefile
├─ diagrams/
│  └─ arch.drawio
├─ scripts/
│  ├─ bootstrap_aws.sh
│  ├─ bootstrap_gcp.sh
│  └─ healthcheck.py
├─ modules/
│  ├─ aws/
│  │  ├─ network/        # VPC, subnets, IGW, route tables
│  │  ├─ compute/        # EC2 + security groups + user_data
│  │  └─ alb/            # Application Load Balancer + target group + listener
│  └─ gcp/
│     ├─ network/        # VPC, subnets, firewall
│     ├─ compute/        # GCE instance + instance group
│     └─ lb/             # HTTP LB (global) or regional TCP proxy
├─ stacks/
│  ├─ aws/
│  │  ├─ main.tf
│  │  ├─ providers.tf
│  │  ├─ variables.tf
│  │  ├─ outputs.tf
│  │  └─ terraform.tfvars.example
│  └─ gcp/
│     ├─ main.tf
│     ├─ providers.tf
│     ├─ variables.tf
│     ├─ outputs.tf
│     └─ terraform.tfvars.example
└─ .github/
   └─ workflows/
      └─ validate-terraform.yml
```
---
## Project Overview
- **AWS:** 1 VPC (2 public subnets), EC2 in ASG optional (start with single EC2)
- **ALB** forwarding to instance, SGs locked to your IP for SSH.
- **GCP:** 1 VPC (1–2 subnets), 1 GCE instance (or MIG later), **HTTP Load Balancer** routing to instance.
- **Python health check script** you can run locally to verify both LBs.
- **Simple web app** (cloud-init installs Nginx with a “Hello from <CLOUD>” page).
---
## Multi-Cloud
	This repo provisions identical, minimal web stacks in **AWS** and **Google Cloud** using **Terraform**:
	- VPC networking
	- Compute (EC2 / GCE)
	- Managed load balancing (ALB / HTTP LB)
	- Simple Nginx app deployed via cloud-init

## Why this project?
	- Demonstrates **multi-cloud environment** and **IaC best practices**
	- Building block for future posts (modules, CI/CD, K8s, cost controls)

## Architecture Diagram



---
## Requirements
	- Terraform ≥ 1.6 AWS CLI, GCloud SDK.
	- AWS credentials (aws configure) and a GCP project with billing enabled (gcloud auth application-default login).

## Steps

### 1) Configure minimal variables

Copy and edit vars:

```cp stacks/aws/terraform.tfvars.example stacks/aws/terraform.tfvars cp stacks/gcp/terraform.tfvars.example stacks/gcp/terraform.tfvars```

Fill in your CIDR/IP and GCP project/region.

### 2) Provision AWS

```cd stacks/aws terraform init terraform apply -auto-approve```

### 3) Provision GCP

```cd ../gcp terraform init terraform apply -auto-approve```

### 4) Verify

- Grab the AWS ALB DNS name and the GCP LB IP/output from Terraform.

	
- Run:

``` python3 scripts/healthcheck.py \

> --aws "<aws load balancer url>" \

> --gcp "<gcp dns ip address>" ```

  

## you should get the following

### [AWS] 200 OK

### [GCP] 200 OK