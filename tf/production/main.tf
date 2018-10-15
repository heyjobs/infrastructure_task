provider "aws" {
    region = "${var.region}"
}

data "template_file" "s3_bucket_policy" {
  template = "${file("${var.dev_xml_bucket_policy}")}"
  
  vars {
    aws_account = "${var.aws_account}"
  }
}

module "create_s3_bucket" {
    source = "../modules/create_s3_bucket"
    
    s3_bucket_name = "${var.dev_xml_bucket_name}"
    s3_bucket_policy = "${data.template_file.s3_bucket_policy.rendered}"
}