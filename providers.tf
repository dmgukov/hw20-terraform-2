provider "aws" {
  alias = "eu-central-1"

  region = "eu-central-1"
  default_tags {
    tags = {
      Hillel    = "Homework 20"
      Terraform = true
    }
  }
}