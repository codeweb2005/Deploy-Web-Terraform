variable "vpc_id" {
  type = string
  description = "The id of the VPC in which to create the security group."
  nullable = false
}
variable "subnet_prensatation_tier" {
  type = list(string)
  description = "The id of the subnet in which to create the security group."
  nullable = false
}
variable "ec2_security_group_ids" {
  type = list(string)
  nullable = false
}
variable "subnet_application_tier" {
  type = list(string)
  description = "The id of the subnet in which to create the security group."
  nullable = false
  
}
variable "ec2_security_group_ids_application" {
  type = list(string)
  nullable = false
  
}