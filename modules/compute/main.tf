resource "aws_instance" "bastion_host" {
  ami           = var.image_id
  instance_type = var.instance_type
  key_name      = var.key_name
  security_groups = var.ec2_security_group_ids_public
  subnet_id = var.subnet_ids[0]
  associate_public_ip_address = true
  availability_zone = var.availability_zone_1
  tags = {
    Name = "bastion_host"
  }

    lifecycle {
    ignore_changes = [security_groups]
  }

}






