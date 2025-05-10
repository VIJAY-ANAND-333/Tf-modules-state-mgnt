terraform {
  backend "s3" {
    bucket         = "tfstate-vj-bucket"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "vj-terraform-lock"
  }
}