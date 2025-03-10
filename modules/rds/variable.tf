variable "private_subnet_ips_data" {
  type = list(string)
  description = "List of subnet IDs"
  default = [ "10.0.5.0/24","10.0.6.0/24" ]
}
variable "security_group_id" {
  type = list(string)
}