variable "project" { type = string }
variable "region"  { 
    type = string  
    default = "us-central1" 
    }
variable "zone"    { 
    type = string  
    default = "us-central1-a" 
    }
variable "ssh_cidr" { type = string }

variable "subnet_cidr" { 
    type = string 
    default = "10.20.1.0/24" 
    }
variable "vpc_name"    { 
    type = string 
    default = "gcp-vpc" 
    }
variable "instances" {
  type = list(string)
}

variable "subnet" {
  description = "The self_link of the subnet to attach instances to"
  type        = string
}
