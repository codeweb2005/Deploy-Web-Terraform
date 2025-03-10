output "presention_target_group_id" {
  value = aws_lb_target_group.presention_target_group.id
  
}
output "application_target_group_id" {
  value = aws_lb_target_group.application_target_group.id
  
}