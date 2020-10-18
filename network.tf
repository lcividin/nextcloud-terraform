resource "aws_security_group" "nextcloud_ec2" {
    name    = "nextcloud_ec2"
    vpc_id  = aws_vpc.nextcloud_vpc.id
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "nextcloud_rds" {
    name    = "nextcloud_rds"
    vpc_id  = aws_vpc.nextcloud_vpc.id
    ingress {
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_vpc" "nextcloud_vpc" {
    cidr_block              = "10.0.0.0/16"
    enable_dns_hostnames    = true
    enable_dns_support      = true
    tags = {
        Name    = "nextcloud-vpc"
    }
}

resource "aws_subnet" "nextcloud_subnet" {
    cidr_block          = "10.0.1.0/24"
    vpc_id              = aws_vpc.nextcloud_vpc.id
    availability_zone   = "${var.aws_region}a"
}

resource "aws_subnet" "nextcloud_subnet2" {
    cidr_block          = "10.0.2.0/24"
    vpc_id              = aws_vpc.nextcloud_vpc.id
    availability_zone   = "${var.aws_region}b"
}

resource "aws_eip" "nextcloud_eip" {
    instance    = aws_instance.nextcloud.id
    vpc         = true
}

resource "aws_internet_gateway" "nextcloud_gw" {
    vpc_id  = aws_vpc.nextcloud_vpc.id
    tags    = {
        Name    = "nextcloud-gw"
    }
}

resource "aws_route_table" "nextcloud_routetable" {
    vpc_id  = aws_vpc.nextcloud_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.nextcloud_gw.id
    }
    tags = {
        Name = "nextcloud-routetable"
    }
}

resource "aws_route_table_association" "subnet-association" {
  subnet_id      = aws_subnet.nextcloud_subnet.id
  route_table_id = aws_route_table.nextcloud_routetable.id
}

resource "aws_db_subnet_group" "_" {
    name        = "nextcloud_db_subnet"
    subnet_ids  = [aws_subnet.nextcloud_subnet.id, aws_subnet.nextcloud_subnet2.id]
}
