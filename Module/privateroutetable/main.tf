resource "aws_route_table" "pv_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.nat_gw_id   
  }

  tags = {
    Name = "private_rt"
  }

}

output "pt_rt_id" {
  value = aws_route_table.pv_rt.id
}