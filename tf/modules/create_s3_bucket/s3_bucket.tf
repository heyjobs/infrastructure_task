resource "aws_s3_bucket" "created_bucket" {

  bucket = "${var.s3_bucket_name}"
  policy = "${var.s3_bucket_policy}"

  tags {
    Terraform   = "True"
  }
}