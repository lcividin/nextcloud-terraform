resource "null_resource" "ec2_instances" {
    triggers = {
        instance_id = aws_instance.nextcloud.id
    }

    provisioner "remote-exec" {
            inline = [
                "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
                "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable\"",
                "sudo apt update",
                "sudo apt install docker.io -y",
                "sudo docker run -e NEXTCLOUD_TRUSTED_DOMAINS=${var.domain} -e MYSQL_DATABASE=\"nextcloud\" -e MYSQL_USER=${var.dbuser} -e MYSQL_PASSWORD=${var.dbpass} -e MYSQL_HOST=${aws_db_instance.nextcloud_db.endpoint} -e NEXTCLOUD_ADMIN_USER=${var.adminuser} -e NEXTCLOUD_ADMIN_PASSWORD=${var.adminpass} -d -p 80:80 nextcloud"
            ]
            connection {
                type = "ssh"
                user = "ubuntu"
                private_key = file(var.private_key_path)
                host = aws_eip.nextcloud_eip.public_ip
                agent = true
                timeout = "1m"
            }    
        }
}
