output "image_name" {
  value = module.ecs.image_name
}

output "flask_lb_dns_name" {
  value = module.alb_flask.load_balancer_dns_name
}

output "react_lb_dns_name" {
  value = module.alb_react.load_balancer_dns_name
}

output "flask_app_policy" {
  value = module.iam_policy.flask_app_policy
}

output "react_app_policy" {
  value = module.iam_policy.react_app_policy
}

output "task_iam_role_name" {
  value = module.ecs.task_name
}