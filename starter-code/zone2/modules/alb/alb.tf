resource "aws_lb" "alb" {
  name               = "alb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = var.public_subnet_ids

  tags = {
    Name = "alb-tf"
  }
}

resource "aws_security_group" "lb_sg" {
  name   = "lb_sg"
  vpc_id = var.vpc_id

  ingress {
    description = "web port"
    from_port   = 80
    to_port     = 80
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
    Name = "ec2_sg"
  }
}

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.alb_target_group.arn
    type             = "forward"
  }
}

resource "aws_alb_listener_rule" "listener_rule" {
  listener_arn = aws_alb_listener.alb_listener.arn
  priority     = 100
  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb_target_group.id
  }
  condition {
    path_pattern {
      values = ["/*"]
    }
  }
  depends_on = [
    aws_alb_target_group.alb_target_group
  ]
}

resource "aws_alb_target_group" "alb_target_group" {
  name     = "web-instances"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 5
    interval            = 10
    path                = "/"
  }
}

resource "aws_alb_target_group_attachment" "ec2_instance" {
  count = length(var.instances_ids)
  target_group_arn = aws_alb_target_group.alb_target_group.arn
  target_id        = var.instances_ids[count.index]
  port             = 80
}