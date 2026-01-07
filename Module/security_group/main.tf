resource "aws_security_group" "web_sg" {
  name = "allow-tls"
  vpc_id = var.vpc_id

  tags = {
    Name = "web-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.web_sg.id
  cidr_ipv4 = var.http_cidr
  from_port = 80
  ip_protocol = "tcp"
  to_port = 80
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.web_sg.id
  cidr_ipv4 = var.ssh_cidr
  from_port = 22
  ip_protocol = "tcp"
  to_port = 22
}

resource "aws_vpc_security_group_egress_rule" "out_bound" {
  security_group_id = aws_security_group.web_sg.id
  cidr_ipv4 = var.egress_cidr
  ip_protocol = "-1"
}

output "security_group_id" {
  value = aws_security_group.web_sg.id
}