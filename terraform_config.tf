terraform {
  required_version = "0.12.13"

  backend "s3" {
    bucket         = "tfstate-508800916858"
    key            = "lcms/eu-central-1/terraform/terraform.tfstate"
    region         = "eu-central-1"
    acl            = "bucket-owner-full-control"
    dynamodb_table = "terraform_locks"
    encrypt        = true
  }
}
