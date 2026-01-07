resource "aws_instance" "web" {
  subnet_id = var.ec_sb_id
  ami = var.ami
  instance_type = var.instance_type
  security_groups = [var.security_group_id]
  key_name = var.key_name   
  associate_public_ip_address = var.associate_public_ip_address

  tags = {
    Name = "bastion-server"
  }
}