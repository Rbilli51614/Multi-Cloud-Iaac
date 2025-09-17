variable "project" { type = string }
variable "region"  { type = string }
variable "zone"    { type = string }

resource "google_compute_health_check" "hc" {
  name = "http-hc"
  http_health_check { port = 80 }
}

resource "google_compute_backend_service" "backend" {
  name                  = "http-backend"
  protocol              = "HTTP"
  port_name             = "http"
  timeout_sec           = 10
  health_checks         = [google_compute_health_check.hc.self_link]
  backend {
    group = google_compute_instance_group.unmanaged.self_link
  }
}

resource "google_compute_instance_group" "unmanaged" {
  name = "web-ig"
  zone = var.zone
  instances = [google_compute_instance.web.self_link]
}

resource "google_compute_url_map" "map" {
  name            = "url-map"
  default_service = google_compute_backend_service.backend.self_link
}

resource "google_compute_target_http_proxy" "proxy" {
  name    = "http-proxy"
  url_map = google_compute_url_map.map.self_link
}

resource "google_compute_global_forwarding_rule" "fr" {
  name       = "http-fr"
  target     = google_compute_target_http_proxy.proxy.self_link
  port_range = "80"
  ip_protocol = "TCP"
}

# Instance for the group
module "instance" {
  source = "../compute"
  project = var.project
  zone    = var.zone
  subnet  = var.subnet
}

variable "subnet" { type = string }

output "lb_ip" { value = google_compute_global_forwarding_rule.fr.ip_address }
