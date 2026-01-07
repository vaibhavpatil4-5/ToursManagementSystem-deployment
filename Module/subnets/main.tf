resource "aws_subnet" "public_subnet_a" {
    vpc_id = var.vpc_id
    cidr_block = var.cidr_block_1a
    availability_zone = var.availability_zone_1a
    tags = {
      Name = "public_subnet_1a"
    }
}

resource "aws_subnet" "public_subnet_b" {
    vpc_id = var.vpc_id
    cidr_block = var.cidr_block_1b
    availability_zone = var.availability_zone_1b
    tags = {
      Name = "public_subnet_1b"
    }
}


output "public_subnet_ids" {
  value = [
    aws_subnet.public_subnet_a.id,
    aws_subnet.public_subnet_b.id
  ]
}
