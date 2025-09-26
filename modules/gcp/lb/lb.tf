variable "project" { type = string }
variable "region"  { type = string }
variable "zone"    { type = string }

variable "subnet" {
  type        = string
  description = "Self link of the subnet"
}

variable "instances" {
  type        = list(string)
  description = "List of instance self_links to attach to the unmanaged instance group"
}

resource "google_compute_instance_group" "unmanaged" {
  name      = "web-unmanaged-group"
  zone      = var.zone
  instances = var.instances
}

# Health check
resource "google_compute_health_check" "hc" {
  name = "http-hc"
  http_health_check { port = 80 }
}

# Backend service
resource "google_compute_backend_service" "backend" {
  name          = "http-backend"
  protocol      = "HTTP"
  port_name     = "http"
  timeout_sec   = 10
  health_checks = [google_compute_health_check.hc.self_link]

  backend {
    # use the self_link from the compute module directly
    group = google_compute_instance_group.unmanaged.self_link
  }
}

# URL map
resource "google_compute_url_map" "map" {
  name            = "url-map"
  default_service = google_compute_backend_service.backend.self_link
}

# HTTP proxy
resource "google_compute_target_http_proxy" "proxy" {
  name    = "http-proxy"
  url_map = google_compute_url_map.map.self_link
}

# Global forwarding rule
resource "google_compute_global_forwarding_rule" "fr" {
  name        = "http-fr"
  target      = google_compute_target_http_proxy.proxy.self_link
  port_range  = "80"
  ip_protocol = "TCP"
}

# Outputs
output "lb_ip" {
  value = google_compute_global_forwarding_rule.fr.ip_address
}

output "backend_self_link" {
  value = google_compute_backend_service.backend.self_link
}

output "health_check_self_link" {
  value = google_compute_health_check.hc.self_link
}
