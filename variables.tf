variable "aws_region" {
    default = "us-east-1"
}

variable "public_key_path" {
    default = "~/.ssh/id_rsa.pub"
}

variable "private_key_path" {
    default = "~/.ssh/id_rsa"
}

variable "ec2_ami" {
    default = "ami-0dba2cb6798deb6d8"
}

variable "ec2_instance_type" {
    default = "t2.nano"
}

variable "rds_instance_type" {
    default = "db.t2.micro"
}

variable "s3_storage_bucket" {
    default = "nextcloud-storage-bucket"
}
