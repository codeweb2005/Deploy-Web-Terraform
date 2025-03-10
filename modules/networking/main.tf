provider "aws" {
  region = var.region
}

#create vpc
resource "aws_vpc" "vpc-demo" {
  cidr_block        = var.cidr_block
  enable_dns_hostnames = true
  tags = {
    Name = "Demo VPC"
  }
}

#create public subnets
resource "aws_subnet" "public-subnet_present_1" {
    vpc_id          = aws_vpc.vpc-demo.id
    cidr_block      = var.public_subnet_ips[0] 
    availability_zone = var.availability_zone_1
    tags = {
      Name = "public-subnet_present_1"
    }
}

resource "aws_subnet" "public-subnet_present_2" {
    vpc_id          = aws_vpc.vpc-demo.id
    cidr_block      = var.public_subnet_ips[1] 
    availability_zone = var.availability_zone_2
    tags = {
      Name = "public-subnet_present_2"
    }
}

resource "aws_subnet" "private-subnet_applications_1" {
    vpc_id          = aws_vpc.vpc-demo.id
    cidr_block      = var.private_subnet_ips[0] 
    availability_zone = var.availability_zone_1
    tags = {
      Name = "private-subnet_applications_1"
    }
}

resource "aws_subnet" "private-subnet_applications_2" {
    vpc_id          = aws_vpc.vpc-demo.id
    cidr_block      = var.private_subnet_ips[1] 
    availability_zone = var.availability_zone_2
    tags = {
      Name = "private-subnet_applications_2"
    }
}

resource "aws_subnet" "private-subnet_data_1" {
    vpc_id          = aws_vpc.vpc-demo.id
    cidr_block      = var.private_subnet_ips[2] 
    availability_zone = var.availability_zone_1
    tags = {
      Name = "private-subnet_data_1"
    }
}

resource "aws_subnet" "private-subnet_data_2" {
    vpc_id          = aws_vpc.vpc-demo.id
    cidr_block      = var.private_subnet_ips[3] 
    availability_zone = var.availability_zone_2
    tags = {
      Name = "private-subnet_data_2"
    }
}

#create internet gateway
resource "aws_internet_gateway" "internetgateway" {
  vpc_id            = aws_vpc.vpc-demo.id
}


#create eip for NAT
resource "aws_eip" "nat_eip" {
}
#create nat-gateway
resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     =aws_subnet.public-subnet_present_1.id 
}

#create public route table
resource "aws_route_table" "route_table_public" {
    vpc_id = aws_vpc.vpc-demo.id
    tags ={
        Name = "Public routetable"
    } 
}

resource "aws_route" "route_public" {
    route_table_id = aws_route_table.route_table_public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internetgateway.id
}
#create private route table
resource "aws_route_table" "route_table_private" {
    vpc_id = aws_vpc.vpc-demo.id
        tags ={
        Name = "Private routetable"
    } 
}

resource "aws_route" "route_private" {
    route_table_id = aws_route_table.route_table_private.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gateway.id
}

#Associate private subnets with private route table
resource "aws_route_table_association" "private_subnet_association_1" {
    subnet_id = aws_subnet.private-subnet_applications_1.id
    route_table_id = aws_route_table.route_table_private.id
}
resource "aws_route_table_association" "private_subnet_association_2" {
    subnet_id = aws_subnet.private-subnet_applications_2.id
    route_table_id = aws_route_table.route_table_private.id
}

resource "aws_route_table_association" "private_subnet_association_3" {
    subnet_id = aws_subnet.private-subnet_data_1.id
    route_table_id = aws_route_table.route_table_private.id
}
resource "aws_route_table_association" "private_subnet_association_4" {
    subnet_id = aws_subnet.private-subnet_data_2.id
    route_table_id = aws_route_table.route_table_private.id
}

resource "aws_route_table_association" "public_subnet_association_1" {
    subnet_id = aws_subnet.public-subnet_present_1.id
    route_table_id = aws_route_table.route_table_public.id
    
}

resource "aws_route_table_association" "public_subnet_association_2" {
    subnet_id = aws_subnet.public-subnet_present_2.id
    route_table_id = aws_route_table.route_table_public.id
}