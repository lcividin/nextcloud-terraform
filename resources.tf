resource "aws_key_pair" "nextcloud_keypair" {
    key_name    = "nextcloud_keypair"
    public_key  = file(var.public_key_path)
}

resource "aws_instance" "nextcloud" {
    ami                     = var.ec2_ami
    instance_type           = var.ec2_instance_type
    tags                    = {
        Name = "nextcloud-main"
    }
    key_name                = "nextcloud_keypair"
    security_groups         = [aws_security_group.nextcloud_ec2.id]
    iam_instance_profile    = aws_iam_instance_profile.nextcloud_profile.name
    subnet_id               = aws_subnet.nextcloud_subnet.id
}

resource "aws_s3_bucket" "nextcloud_storage" {
    bucket = var.s3_storage_bucket
    acl = "private"
}

resource "aws_db_instance" "nextcloud_db" {
    allocated_storage       = 20
    availability_zone       = "${var.aws_region}a"
    identifier              = "nextcloud-db"
    storage_type            = "gp2"
    engine                  = "mysql"
    engine_version          = "5.7"
    instance_class          = var.rds_instance_type
    name                    = "nextcloud"
    username                = var.dbuser
    password                = var.dbpass
    parameter_group_name    = "default.mysql5.7"
    deletion_protection     = true
    publicly_accessible     = true
    vpc_security_group_ids  = [aws_security_group.nextcloud_rds.id]
    db_subnet_group_name    = aws_db_subnet_group._.name
}
