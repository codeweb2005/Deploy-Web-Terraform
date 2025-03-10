variable "region" {
  type = string
  default = "ap-southeast-1"
}

variable "image_id" {
  type = string
  description = "The id of the machine image (AMI) to use for the server."
}

variable "key_name" {
  type = string
  description = "name of the keypair to use for the instance"
  nullable = false
}


variable "instance_type" {
  type = string
  description = "this is intance type"
  default = "t2.micro"
}

variable "ec2_security_group_ids_public" {
  type = list(string)
  nullable = false
}
variable "availability_zone_1" {
  type = string
  description = "availability zone first subnet"
  nullable = false
}
variable "subnet_ids" {
  type = list(string)
  description = "The id of the subnet to launch the instance in."
  nullable = false
}
