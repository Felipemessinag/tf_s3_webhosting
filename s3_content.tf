resource "aws_s3_object" "html" {
  bucket       = aws_s3_bucket.nextwork.id
  acl          = "public-read"
  key          = "index.html"
  source       = "s3_files/html/index.html"
  content_type = "text/html"
}

resource "aws_s3_bucket_cors_configuration" "nextwork_cors" {
  bucket = aws_s3_bucket.nextwork.id

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    allowed_headers = ["*"]
  }
}
