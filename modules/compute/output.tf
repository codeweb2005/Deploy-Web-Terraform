output "instance_id_private_bastion_host" {
  value = aws_instance.bastion_host.private_ip
}
output "instance_id_public_bastion_host" {
  value = aws_instance.bastion_host.public_ip
}
