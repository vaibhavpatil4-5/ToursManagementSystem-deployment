resource "aws_vpc" "myvpc" {
     cidr_block = var.vpc_cidr
     tags = {
       Name = "vpc-(IAC)"
     }
}

output "vpc_id" {
  value = aws_vpc.myvpc.id
}