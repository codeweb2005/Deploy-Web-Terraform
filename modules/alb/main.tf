resource "aws_lb" "presentation-tier-alb" {
  name               = "presentation-tier-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.ec2_security_group_ids
  subnets            = var.subnet_prensatation_tier
  enable_deletion_protection = false
  tags = {
    Name = "loadbalancer"
  }
  
}
resource "aws_lb_target_group" "presention_target_group" {
  port     = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id
  health_check {
    path                = "/health"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}
resource "aws_lb_listener" "presentation_listener" {
  load_balancer_arn = aws_lb.presentation-tier-alb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.presention_target_group.arn
  }
  
}
# --------------------------application-----------------------------
resource "aws_lb" "application-tier-alb" {
  name               = "application-tier-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = var.ec2_security_group_ids_application
  subnets            = var.subnet_application_tier
  enable_deletion_protection = false
  tags = {
    Name = "loadbalancer"
  }
  
}
resource "aws_lb_target_group" "application_target_group" {
  port     = 3200
  protocol = "HTTP"
  vpc_id = var.vpc_id
  health_check {
    path                = "/health"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}
resource "aws_lb_listener" "application_listener" {
  load_balancer_arn = aws_lb.application-tier-alb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.application_target_group.arn
  }
}