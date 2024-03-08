output "image_name" {
  value = "${module.ecs.image_name}"
}

output "flask_lb_dns_name" {
  value = "${module.alb_flask.load_balancer_dns_name}"
}

output "react_lb_dns_name" {
  value = "${module.alb_react.load_balancer_dns_name}"
} 