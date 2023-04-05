terraform {
  required_version = "= 1.4.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 4.57.0"
    }

  }
  backend "s3" {
    bucket = "tf-bucket-nebius"
    key    = "state/terraform.tfstate"
    region = "eu-west-1"
  }
}
provider "aws" {
  region = "eu-west-1"
  default_tags {
    tags = {
      Owner  = "ZToth"
      Origin = "Terraform Provisioned"
    }
  }
}
