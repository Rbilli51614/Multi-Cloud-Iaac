variable "project" { type = string }
variable "zone"    { type = string }
variable "subnet"  { type = string }

resource "google_compute_instance" "web" {
  name         = "gcp-web"
  machine_type = "e2-micro"
  zone         = var.zone
  boot_disk { 
    initialize_params { image = "debian-cloud/debian-12" } 
  }
  network_interface { 
    subnetwork = var.subnet
    access_config {}
  }
  metadata_startup_script = file("${path.module}/../../../../scripts/bootstrap_gcp.sh")
  tags = ["web"]
}

output "instance_self_link" { value = google_compute_instance.web.self_link }
