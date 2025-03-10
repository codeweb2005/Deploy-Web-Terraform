variable "security_group_presentation_tier_lt" {
  type = list(string)
}
variable "subnet_ids" {
  type = list(string)
  description = "The id of the subnet in which to create the security group."
  nullable = false
}

variable "instance_type" {
  type = string
  description = "this is intance type"
  default = "t2.micro"
}

variable "taget_group_arns" {
  type = list(string)
  nullable = false
}
variable "image_id" {
  type = string
}
variable "key_pair" {
  type = string
}

variable "security_group_application_tier_lt" {
  type = list(string)
}
variable "taget_group_arns_application" {
  type = list(string)
  nullable = false
}
variable "subnet_ids_application" {
  type = list(string)
  description = "The id of the subnet in which to create the security group."
  nullable = false
  
}