// Populated from environment variables via TF_VAR_public_key
variable "public_key" {}

resource "aws_key_pair" "nextcloud_keypair" {
    key_name = "nextcloud_keypair"
    public_key = var.public_key
}
resource "aws_security_group" "nextcloud_http_globally_accessible" {
    name = "nextcloud_http_globally_accessible"
    ingress { 
        from_port = 80    
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "nextcloud_ingress_globally_accessible" {
    name = "nextcloud_ingress_globally_accessible"
    ingress { 
        from_port = 22    
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "nextcloud" {
    ami = "ami-07bfe0a3ec9dfcffa"
    instance_type = "t2.micro"
    tags = {
        Name = "nextcloud-main"
    }
    key_name = "nextcloud_keypair"
    security_groups = [aws_security_group.nextcloud_ingress_globally_accessible.name, aws_security_group.nextcloud_http_globally_accessible.name]
    provisioner "remote-exec" {
        inline = [
            "sudo snap wait system seed.loaded",
            "sudo snap install nextcloud",
            "sudo nextcloud.manual-install root root",
            "sudo nextcloud.occ config:system:set trusted_domains 0 --value ${aws_instance.nextcloud.public_dns}",
            "sudo snap set nextcloud php.memory-limit=512M",
        ]
        connection {
            type = "ssh"
            user = "ubuntu"
            private_key = file("~/.ssh/id_rsa")
            host = aws_instance.nextcloud.public_ip
            agent = true
            timeout = "1m"
        }    
    }
}
