resource "aws_internet_gateway" "igw-1" {
    vpc_id = var.vpc_id
    tags = {
      Name = "Igw"
    }
}

output "igw_id" {
  value = aws_internet_gateway.igw-1.id
}