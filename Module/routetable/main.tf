resource "aws_route_table" "public_rt" {
  vpc_id = var.vpc_id
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igwid
  }                              
  tags = {
    Name = "public-rt"
  }
}

output "rw_id" {
  value = aws_route_table.public_rt.id
}