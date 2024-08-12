resource "aws_s3_bucket" "nextwork" {
  bucket = "nextwork-website-project-felipe"
  tags = {
    Name        = "nextwork-bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_ownership_controls" "nextwork_s3" {
  bucket = aws_s3_bucket.nextwork.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "nextwork_s3_access" {
  bucket = aws_s3_bucket.nextwork.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "nextwork_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.nextwork_s3,
    aws_s3_bucket_public_access_block.nextwork_s3_access,
  ]
  bucket = aws_s3_bucket.nextwork.id
  access_control_policy {
    grant {
      grantee {
        id   = data.aws_canonical_user_id.current.id
        type = "CanonicalUser"
      }
      permission = "READ"

    }
    owner {
      id = data.aws_canonical_user_id.current.id
    }
  }
}

resource "aws_s3_bucket_website_configuration" "nextwork_website" {
  bucket = aws_s3_bucket.nextwork.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_policy" "nextwork_policy" {
  bucket = aws_s3_bucket.nextwork.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.nextwork.arn}/*"
      }
    ]
  })
}
