# # Unique string to guaruntee unique name
# resource "random_string" "unique_resource_string" {
#   length = 10
#   special = false
#   upper = false
# }

# Load Zone data from Account with search by root zone
data "aws_route53_zone" "selected" {
  name         = "${var.site_root_zone}"
}

# Create S3 bucket for static site
resource "aws_s3_bucket" "site_data" {
  bucket = "${var.site_host}.${var.site_root_zone}"
  acl    = "public-read"
  website {
    index_document = "index.html"
    error_document = "index.html"
  }
}

# Configure S3 bucket with public policy
resource "aws_s3_bucket_policy" "site_data" {
  bucket = "${aws_s3_bucket.site_data.bucket}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowPublicRead",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "s3:GetObject",
            "Resource": "${aws_s3_bucket.site_data.arn}/*"
        }
    ]
}
EOF
}

# Create DNS entry targeting S3 bucket website endpoint
resource "aws_route53_record" "terraform" {
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name    = "${var.site_host}"
  type    = "CNAME"
  ttl     = "5"
  records        = ["${aws_s3_bucket.site_data.website_endpoint}"]
}

# Add index.html file to bucket
resource "aws_s3_bucket_object" "index" {
  bucket = "${aws_s3_bucket.site_data.bucket}"
  key    = "index.html"
  source = "./index.html"
  etag   = "${md5(file("./index.html"))}"
  content_type = "text/html"
}