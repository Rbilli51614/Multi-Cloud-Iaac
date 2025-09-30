terraform {
  required_version = ">= 1.6"
  required_providers {
<<<<<<< HEAD
    aws = { source = "hashicorp/aws" 
    version = "~> 5.0" }
=======
    aws = { source = "hashicorp/aws" version = "~> 5.0" }
>>>>>>> a240d67466d6af8db9b0490d6e6bdfe53929bc9e
  }
}

provider "aws" {
  region = var.region
}
