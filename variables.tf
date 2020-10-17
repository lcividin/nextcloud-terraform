variable "public_key_path" {
    default = "~/.ssh/id_rsa.pub"
}

variable "private_key_path" {
    default = "~/.ssh/id_rsa"
}

variable "ec2_ami" {
    default = "ami-07bfe0a3ec9dfcffa"
}

variable "ec2_instance_type" {
    default = "t2.micro"
}


