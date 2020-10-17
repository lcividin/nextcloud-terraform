resource "aws_key_pair" "nextcloud_keypair" {
    key_name = "nextcloud_keypair"
    public_key = file(var.public_key_path)
}

resource "aws_instance" "nextcloud" {
    ami = var.ec2_ami 
    instance_type = var.ec2_instance_type
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
            private_key = file(var.private_key_path)
            host = aws_instance.nextcloud.public_ip
            agent = true
            timeout = "1m"
        }    
    }
}
