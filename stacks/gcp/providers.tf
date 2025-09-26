terraform {
  required_providers {
    google = { 
      source = "hashicorp/google" 
      version = "~> 5.0" }
  }
  required_version = ">= 1.6"
}
provider "google" {
  project     = var.project
  region      = var.region
  zone        = var.zone
  credentials = file(var.credentials_file)
}
