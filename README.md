Multi-Cloud Infrastructure as Code (Terraform AWS + GCP VPC-EC2-Load Balancer)

## Folder Structure

multi-cloud-iac/
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
