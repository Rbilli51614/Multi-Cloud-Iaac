module "net" {
  source         = "../../modules/aws/network"
  vpc_cidr       = var.vpc_cidr
  public_subnets = var.public_subnets
  region         = var.region
}

module "compute" {
  source            = "../../modules/aws/compute"
  vpc_id            = module.net.vpc_id
  subnet_id         = module.net.public_subnet_ids[0]
  key_name          = var.ssh_key_name
  ingress_cidr_ssh  = var.ingress_cidr_ssh
}

module "alb" {
  source              = "../../modules/aws/alb"
  vpc_id              = module.net.vpc_id
  subnet_ids          = module.net.public_subnet_ids
  target_instance_id  = module.compute.instance_id
}


