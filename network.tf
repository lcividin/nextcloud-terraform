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

