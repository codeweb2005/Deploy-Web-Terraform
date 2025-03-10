variable "region" {
  type = string
}

variable "cidr_block" {
    type = string
    nullable = false
}

variable "public_subnet_ips" {
  type     = list(string)
  nullable = false
}
variable "private_subnet_ips" {
  type     = list(string)
  nullable = false
}
variable "availability_zone_1" {
  type        = string
  description = "availability zone first subnet"
}
variable "availability_zone_2" {
  type        = string
  description = "availability zone second subnet"
}
# variable "security_group_id" {
#   type = string
# }
