output "ec2_public_ip_addr" {
    value = aws_eip.nextcloud_eip.public_ip
}

output "ec2_public_dns_addr" {
    value = aws_eip.nextcloud_eip.public_dns
}

output "rds_endpoint" {
    value = aws_db_instance.nextcloud_db.endpoint
}
