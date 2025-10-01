variable "project" { type = string }
variable "region"  { type = string }
variable "vpc_name" { 
  type = string 
  default = "gcp-vpc" 
  }
variable "subnet_cidr" { 
  type = string 
  default = "10.20.1.0/24" 
  }

resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.vpc_name}-subnet"
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc.id
}

resource "google_compute_firewall" "allow-http" {
  name    = "allow-http"
  network = google_compute_network.vpc.name
  allow { 
    protocol = "tcp" 
    ports = ["80"] 
    }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow-ssh" {
  name    = "allow-ssh"
  network = google_compute_network.vpc.name
  allow { 
    protocol = "tcp" 
    ports = ["22"] 
    }
  source_ranges = [var.ssh_cidr]
}

variable "ssh_cidr" { type = string }

output "network" { value = google_compute_network.vpc.name }
output "subnet"  { value = google_compute_subnetwork.subnet.name }
output "subnet_self_link" {
  value = google_compute_subnetwork.subnet.self_link
}

