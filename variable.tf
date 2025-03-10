variable "region" {
  type = string
  default = "ap-southeast-1"
}

variable "keypath" {
  type = string
  default = "./keypairnew/my-key.pub"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "aims" {
  type = map(any)
  default = {
    "ap-southeast-1" : "ami-0b03299ddb99998e9"
    "ap-northeast-1" : "ami-072298436ce5cb0c4"
  }
}

variable "cidr_block" {
    type = string
    nullable = false
}

variable "public_subnet_ips" {
  type = list(string)
}

variable "private_subnet_ips" {
  type = list(string)
  
}
variable "availability_zone_1" {
  type        = string
  description = "availability zone first subnet"
}
variable "availability_zone_2" {
  type        = string
  description = "availability zone second subnet"
}
