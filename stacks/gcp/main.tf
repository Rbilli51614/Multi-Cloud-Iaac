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
  instances = [module.compute.instance_self_link]  # ✅ pass in from compute
}

module "compute" {
  source = "../../modules/gcp/compute"
  project = var.project
  zone    = var.zone
  subnet  = module.net.subnet_self_link
}

output "gcp_lb_ip" { value = module.lb.lb_ip }
