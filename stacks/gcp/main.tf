module "net" {
  source       = "../../modules/gcp/network"
  project      = var.project
  region       = var.region
  subnet_cidr  = var.subnet_cidr
  vpc_name     = var.vpc_name
  ssh_cidr     = var.ssh_cidr
}

module "lb" {
  source = "../../modules/gcp/lb"
  project = var.project
  region  = var.region
  zone    = var.zone
  subnet  = var.subnet
  instance_self_link = module.compute.web_instance_self_link
}
module "compute" {
  source  = "../../modules/gcp/compute"   # path to your compute module
  project = var.project
  zone    = var.zone
  subnet  = module.net.subnet_self_link  # pass the real subnet self_link
}


output "gcp_lb_ip" { value = module.lb.lb_ip }
