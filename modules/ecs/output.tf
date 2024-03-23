output "image_name" {
  value = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${var.ecr_repository_name}:latest"
}

output "services" {
  value = module.ecs.services
}