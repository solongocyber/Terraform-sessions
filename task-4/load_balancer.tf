resource "aws_lb" "webserver-alb" {
  name               = "${var.env}-web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-sg.id]
 
  subnets            = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id, aws_subnet.public-subnet-3.id ]
}

resource "aws_lb_listener" "webserver-listerner" {
  load_balancer_arn = aws_lb.webserver-alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webserver-tg.arn
  }
}

resource "aws_security_group" "alb-sg" {
  name        = "${var.env}-applb-sg"
  description = "Allow HTTP traffic"
  vpc_id = aws_vpc.task4-vpc.id # VPC in here if you use custom  VPC. 
}

resource "aws_security_group_rule" "http_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb-sg.id
}


resource "aws_security_group_rule" "alb-egress" {
  type              = "egress"
  from_port         = "80"
  to_port           = "80"
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb-sg.id
}