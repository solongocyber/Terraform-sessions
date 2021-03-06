resource "aws_s3_bucket" "main-bucket" {
  bucket = "${var.env}-terraform-session-solongo"
  acl    = "private"

  tags = local.tags
}

resource "aws_s3_bucket_public_access_block" "main-bucket" {
  bucket = aws_s3_bucket.main-bucket.id

  block_public_acls   = true
  block_public_policy = true
 ignore_public_acls = true
  restrict_public_buckets = true
}