terraform {
  required_providers {
<<<<<<< HEAD
    google = { source = "hashicorp/google" 
    version = "~> 5.0" }
=======
    google = { source = "hashicorp/google" version = "~> 5.0" }
>>>>>>> a240d67466d6af8db9b0490d6e6bdfe53929bc9e
  }
  required_version = ">= 1.6"
}

provider "google" {
  project = var.project
  region  = var.region
}
