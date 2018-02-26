resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = ["${var.db_subnet_id_1}", "${var.db_subnet_id_2}", "${var.db_subnet_id_3}"]

  tags {
    Name = "notejam subnet"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.6.37"
  instance_class       = "db.t2.small"
  name                 = "mydb"
  username             = "${var.db_username}"
  password             = "${var.db_password}"
  db_subnet_group_name = "main"
  parameter_group_name = "default.mysql5.6"
  storage_encrypted = true
  multi_az = true
  backup_retention_period = 7
}
