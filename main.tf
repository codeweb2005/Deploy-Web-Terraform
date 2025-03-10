
provider "aws" {
  region = var.region
}

resource "aws_key_pair" "keypair" {
  key_name = "keypair"
  public_key = file(var.keypath)
}

module "security" {
  source = "./modules/security"
  region = var.region
  vpc_id =  module.networking.vpc_id
}

module "networking" {
  source = "./modules/networking"
  region = var.region
  cidr_block = var.cidr_block
  public_subnet_ips = var.public_subnet_ips
  private_subnet_ips = var.private_subnet_ips
  availability_zone_1 = var.availability_zone_1
  availability_zone_2 = var.availability_zone_2  
}

module "compute" {
  source = "./modules/compute"
  region = var.region
  image_id = "ami-0b03299ddb99998e9"
  instance_type = var.instance_type
  key_name = aws_key_pair.keypair.key_name
  subnet_ids = [module.networking.public_subnet_ids[0]]
  availability_zone_1 = var.availability_zone_1
  ec2_security_group_ids_public = [module.security.bastion_host_security_group_id]
}
module "data" {
  source = "./modules/rds"
  private_subnet_ips_data = [module.networking.private_subnet_ids[2],module.networking.private_subnet_ids[3]]
  security_group_id = [module.security.data_tier_id]
}
module "alb" {
  source = "./modules/alb"
  vpc_id = module.networking.vpc_id
  subnet_prensatation_tier = [module.networking.public_subnet_ids[0],module.networking.public_subnet_ids[1]]
  ec2_security_group_ids = [module.security.prensentation_tier_alb_id]
  ec2_security_group_ids_application = [module.security.application_tier_alb_id]
  subnet_application_tier = [module.networking.private_subnet_ids[0],module.networking.private_subnet_ids[1]]
}
module "launch_template" {
  source = "./modules/launch_template"
  taget_group_arns = [module.alb.presention_target_group_id]
  image_id = "ami-0b03299ddb99998e9"
  instance_type = var.instance_type
  key_pair = aws_key_pair.keypair.key_name
  security_group_application_tier_lt = [module.security.application_tier_ec2_id]
  security_group_presentation_tier_lt = [module.security.prensentation_tier_ec2_id]
  subnet_ids = [module.networking.public_subnet_ids[0],module.networking.public_subnet_ids[1]]
  taget_group_arns_application = [module.alb.application_target_group_id]
  subnet_ids_application = [module.networking.private_subnet_ids[0],module.networking.private_subnet_ids[1]]
}


