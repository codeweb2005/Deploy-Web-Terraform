resource "aws_db_subnet_group" "subnet_group" {
    name       = "subnet_group"
    subnet_ids = var.private_subnet_ips_data
    tags = {
        Name = "subnet_group"
    }
}

resource "aws_db_instance" "new_database" {
  allocated_storage    = 200
  db_name              = "new_database"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "912005za"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.subnet_group.id
  vpc_security_group_ids = var.security_group_id
}