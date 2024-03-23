# resource "aws_ecr_repository" "my_sample_repo" {
#   name = "${var.name_prefix}-${var.service_type}"
#   image_tag_mutability = "MUTABLE"

#   force_delete = true

#   # image_scanning_configuration {
#   #   scan_on_push = true
#   # }
# }


module "ecs" {
  source = "terraform-aws-modules/ecs/aws"

  cluster_name = "${var.name_prefix}-${var.service_type}-ecs"

  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 100
      }
    }

  }
  
  services = {
    "${var.name_prefix}-${var.service_type}-svc" = { #This is service-name
      cpu    = 512
      memory = 1024

      # Container definition(s)
      container_definitions = {

        ecs-sample = {
          cpu       = 512
          memory    = 1024
          essential = true
          image     = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${var.ecr_repository_name}:latest"
          # image = "255945442255.dkr.ecr.ap-southeast-1.amazonaws.com/${local.prefix}:latest"
          port_mappings = [
            {
              containerPort = var.container_port_mapping
              protocol      = "tcp"
            }
          ]
          readonly_root_filesystem= false
        }
      }

      assign_public_ip = local.public_ip_needed
      deployment_minimum_healthy_percent = 100
      subnet_ids = flatten(var.all_subnets)
      security_group_ids = [module.ecs_sg.security_group_id]

      
      load_balancer = local.load_balancer_needed ? {
        service = {
          target_group_arn = var.target_group_arn
          container_name = "ecs-sample"
          container_port = var.container_port_mapping
        }
      } : {}
    }
  } 

  tags = {
    Environment = "Development-${var.service_type}"
    Project     = "${var.name_prefix}-${var.service_type}-example"
  }
}



module "ecs_sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "~> 5.1.0"

  name = "${var.name_prefix}-${var.service_type}-sg-1"
  description = "Security group for ${var.service_type}"

  vpc_id      = var.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = local.ingress_rule_list
  egress_rules        = ["all-all"]
}