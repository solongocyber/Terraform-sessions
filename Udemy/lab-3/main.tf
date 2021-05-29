provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "web" {
ami = "ami-0d5eff06f840b45e9"
instance_type = "t2.micro"
vpc_security_group_ids = [aws_security_group.web.id]
user_data = file("user_data.sh")
tags = {
    Name = "web"
    Project = "udemy"
    Owner = "Solongo" 
 }
}