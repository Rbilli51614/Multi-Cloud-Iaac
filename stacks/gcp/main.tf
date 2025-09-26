# --- Network Module ---
module "net" {
  source       = "../../modules/gcp/network"
  project      = var.project
  region       = var.region
  vpc_name     = var.vpc_name
  subnet_cidr  = var.subnet_cidr
  ssh_cidr     = var.ssh_cidr
}

# --- Load Balancer Module ---
module "lb" {
  source       = "../../modules/gcp/lb"
  project      = var.project
  region       = var.region
  zone         = var.zone
  subnet       = module.net.subnet_self_link       # instance(s) from compute module
  instances    = [module.compute.instance_self_link]   # <-- pass the compute instance(s)
}

# --- Compute Module ---
module "compute" {
  source = "../../modules/gcp/compute"
  project = var.project
  zone    = var.zone
  subnet  = module.net.subnet_self_link
  
}