resource "aws_iam_role" "nextcloud_role" {
    name = "nextcloud_role"

    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "nextcloud_profile" {
    name = "nextcloud_profile"
    role = aws_iam_role.nextcloud_role.name
}

resource "aws_iam_role_policy" "nextcloud_s3_policy" {
    name = "nextcloud_policy"
    role = aws_iam_role.nextcloud_role.id

    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${var.s3_storage_bucket}/*"
    }
  ]
}
EOF
}
