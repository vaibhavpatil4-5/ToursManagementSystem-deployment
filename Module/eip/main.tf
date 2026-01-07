resource "aws_eip" "myeip" {
    domain = var.domain
}

output "eip_id" {
    value = aws_eip.myeip.id  
}