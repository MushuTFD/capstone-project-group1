module "vpc" {
  source = "./modules/vpc"

  cidr_block = "10.0.0.0/16"
  name_prefix = "${local.name_prefix}"
  public_subnet_count = 3
  private_subnet_count = 3
  create_natgw = true
}
# module "alb" {
#   source = "./modules/alb"
#   name_prefix = "${local.name_prefix}"

#   all_subnets = module.vpc.public_subnets
#   vpc_id = module.vpc.vpc_id
# }

module "ecs" {
  source = "./modules/ecs"
  name_prefix = "${local.name_prefix}"
  vpc_id = module.vpc.vpc_id

  all_subnets = module.vpc.private_subnets
  public_or_private = "private"

  service_type = "flask"
  # ecr_repository_name. Exact name as in the ECR. Create the ECR first then push the script inside
  ecr_repository_name = "richie-flask-app"
  container_port_mapping = 8080
  
}

module "ecs_react_frontend" {
  source = "./modules/ecs"
  name_prefix = "${local.name_prefix}"
  vpc_id = module.vpc.vpc_id
  all_subnets = module.vpc.public_subnets
  public_or_private = "public"

  service_type = "react-1"
  # ecr_repository_name. Exact name as in the ECR. Create the ECR first then push the script inside
  ecr_repository_name = "richie-react-app" 
  container_port_mapping = 80

}