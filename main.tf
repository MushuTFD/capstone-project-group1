module "vpc" {
  source = "./modules/vpc"

  cidr_block = "10.0.0.0/16"
  name_prefix = "${local.name_prefix}"
  public_subnet_count = 3
  private_subnet_count = 3
  create_natgw = true
}
module "alb_flask" {
  source = "./modules/alb"
  name_prefix = "${local.name_prefix}"
  service_type = "${local.backend_service}"

  all_subnets = module.vpc.public_subnets
  vpc_id = module.vpc.vpc_id
}

module "alb_react" {
  source = "./modules/alb"
  name_prefix = "${local.name_prefix}"
  service_type = "${local.frontend_service}"

  all_subnets = module.vpc.public_subnets
  vpc_id = module.vpc.vpc_id

}

module "ecs" {
  source = "./modules/ecs"
  name_prefix = "${local.name_prefix}"
  vpc_id = module.vpc.vpc_id

  all_subnets = module.vpc.private_subnets
  public_or_private = "private"

  service_type = "${local.backend_service}"
  # ecr_repository_name. Exact name as in the ECR. Create the ECR first then push the script inside
  ecr_repository_name = "${local.backend_repository}"
  container_port_mapping = 8080

  attach_lb_bool = true
  target_group_arn = module.alb_flask.target_group_arn
  
}

module "ecs_react_frontend" {
  source = "./modules/ecs"
  name_prefix = "${local.name_prefix}"
  vpc_id = module.vpc.vpc_id
  all_subnets = module.vpc.public_subnets
  public_or_private = "public"

  service_type = "${local.frontend_service}"
  # ecr_repository_name. Exact name as in the ECR. Create the ECR first then push the script inside
  ecr_repository_name = "${local.frontend_repository}" 
  container_port_mapping = 80

  attach_lb_bool = true
  target_group_arn = module.alb_react.target_group_arn

}

module "route53_react" {
  source = "./modules/routes53"
  alb_dns_name = module.alb_react.load_balancer_dns_name
  zone_id = module.alb_react.load_balancer_zone_id
}
