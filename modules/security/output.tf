
output "bastion_host_security_group_id" {
  value = aws_security_group.bastion_host.id
  
}
output "data_tier_id" {
  value = aws_security_group.data_tier.id
}
output "prensentation_tier_ec2_id" {
  value = aws_security_group.prensentation_tier_ec2.id
  
}

output "prensentation_tier_alb_id" {
  value = aws_security_group.prensentation_tier_alb.id
  
}
output "application_tier_ec2_id" {
  value = aws_security_group.application_tier_ec2.id
  
}
output "application_tier_alb_id" {
  value = aws_security_group.application_tier_alb.id
  
}