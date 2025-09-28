module "net" {
  source       = "../../modules/gcp/network"
  project      = var.project
  region       = var.region
  subnet_cidr  = var.subnet_cidr
  vpc_name     = var.vpc_name
  ssh_cidr     = var.ssh_cidr
}

module "lb" {
  source  = "../../modules/gcp/lb"
  project = var.project
  region  = var.region
  zone    = var.zone
  subnet  = module.net.subnet
}

output "gcp_lb_ip" { value = module.lb.lb_ip }
