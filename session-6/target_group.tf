resource "aws_lb_target_group" "webserver-tg" {
  name     = "${var.env}-webserver-alb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id  #If custom VPC it's in here.
}

