resource "aws_lb" "public_alb" {
  name               = "${var.prefix_name}-public-load-balancer"
  internal           = false
  load_balancer_type = "application"
  # security_groups    = [aws_security_group.my_alb_sg.id]
  subnets            = var.all_subnets
  enable_deletion_protection = false

  tags = {
    Name = "${var.prefix_name}-public-load-balancer"
  }
}