resource "aws_lb" "public_alb" {
  name               = "${var.name_prefix}-public-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public_alb_sg.id]
  subnets            = var.all_subnets
  enable_deletion_protection = false

  tags = {
    Name = "${var.name_prefix}-public-lb"
  }
}

resource "aws_security_group" "public_alb_sg" {
  name = "${var.name_prefix}-public-lb-sg"
  description = "Security group for public load balancer"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}-public-alb-sg"
  }

}

resource "aws_lb_target_group" "public_tg" {
  name     = "${var.name_prefix}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name = "${var.name_prefix}-tg"
  }
}

resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.public_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action { 
    type             = "forward"
    target_group_arn = aws_lb_target_group.public_tg.arn
  }
}

# Create EC2 within my VPC
# module "ec2" {
#   source = "../ec2"

#   name_prefix = "${var.name_prefix}"
#   public_subnet_ids = var.all_subnets
#   no_of_ec2 = 3
# }