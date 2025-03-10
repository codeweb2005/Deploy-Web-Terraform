output "vpc_id" {
  value = aws_vpc.vpc-demo.id
}

output "private_subnet_ids" {
  value = [
    aws_subnet.private-subnet_applications_1.id,
    aws_subnet.private-subnet_applications_2.id,
    aws_subnet.private-subnet_data_1.id,
    aws_subnet.private-subnet_data_2.id
  ]
}

output "public_subnet_ids" {
  value = [
    aws_subnet.public-subnet_present_1.id,
    aws_subnet.public-subnet_present_2.id
  ]
}

output "private_route_table_id" {
  value = aws_route_table.route_table_private.id
}

output "public_route_table_id" {
  value = aws_route_table.route_table_public.id
}

output "nat-gateway-id" {
  value = aws_nat_gateway.nat-gateway.id
}

