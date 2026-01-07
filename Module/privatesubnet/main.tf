resource "aws_subnet" "private_subnet_1a" {
    vpc_id = var.vpc_id
    cidr_block = var.cidr_block_1a
    availability_zone = var.availability_zone_1a
    tags = {
      Name = "private_subnet_1a"
    }
}

resource "aws_subnet" "private_subnet_1b" {
    vpc_id = var.vpc_id
    cidr_block = var.private_cidr_block
    availability_zone = var.private_availability_zone
    tags = {
      Name = "private_subnet_1b"
    }
}

output "pvt_subnet_ids" {
  value = [ 
    aws_subnet.private_subnet_1a.id,
    aws_subnet.private_subnet_1b.id
  ]
}

