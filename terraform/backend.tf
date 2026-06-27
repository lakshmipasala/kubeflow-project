terraform {
  backend "s3" {
    bucket  = "test12345567891234"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}