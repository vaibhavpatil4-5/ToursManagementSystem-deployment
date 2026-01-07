resource "aws_nat_gateway" "nat_igw" {

  allocation_id = var.allocation_id
  subnet_id = var.subnet_ids
  
  tags = {
    Name = "nat-igw"
  }
}


output "nat_id" {
 value = aws_nat_gateway.nat_igw.id 
}