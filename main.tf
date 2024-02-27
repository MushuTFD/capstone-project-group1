module "vpc" {
  source = "./modules/vpc"

  cidr_block = "10.0.0.0/16"
  name_prefix = "${local.name_prefix}"
  public_subnet_count = 3
  private_subnet_count = 3
  create_natgw = true
}
module "alb" {
  source = "./modules/alb"
  name_prefix = "${local.name_prefix}"

  all_subnets = module.vpc.public_subnets
  vpc_id = module.vpc.vpc_id
}
