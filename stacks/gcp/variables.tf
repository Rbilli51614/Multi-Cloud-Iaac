variable "project" { type = string }
<<<<<<< HEAD
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
=======
variable "region"  { type = string  default = "us-central1" }
variable "zone"    { type = string  default = "us-central1-a" }
variable "ssh_cidr" { type = string }

variable "subnet_cidr" { type = string default = "10.20.1.0/24" }
variable "vpc_name"    { type = string default = "gcp-vpc" }
>>>>>>> a240d67466d6af8db9b0490d6e6bdfe53929bc9e
