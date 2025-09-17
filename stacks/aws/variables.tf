variable "region" { type = string  default = "us-east-1" }
variable "vpc_cidr" { type = string default = "10.10.0.0/16" }
variable "public_subnets" { type = list(string) default = ["10.10.1.0/24","10.10.2.0/24"] }
variable "ssh_key_name" { type = string }
variable "ingress_cidr_ssh" { type = string } # e.g., "YOUR_IP/32"
