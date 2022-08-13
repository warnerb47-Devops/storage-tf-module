
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# load config file
locals {
  input_file         = "./config.yml"
  input_file_content = fileexists(local.input_file) ? file(local.input_file) : "NoInputFileFound: true"
  input              = yamldecode(local.input_file_content)
}


# Configure the AWS Provider
provider "aws" {
  region     = local.input.access.region
  access_key = local.input.access.access_key
  secret_key = local.input.access.secret_key
}


resource "aws_s3_bucket" "bucket" {
  count  = length(local.input.s3_buckets)
  bucket = local.input.s3_buckets[count.index].name
}

resource "aws_ecr_repository" "ecr" {
  count                = length(local.input.ecr)
  name                 = local.input.ecr[count.index].name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}

output "buckets_and_ecrs" {
  value = {
    bucket = [for s3_bucket in aws_s3_bucket.bucket : {
      bucket                      = s3_bucket.bucket
      s3_uri                      = "s3://${s3_bucket.bucket}"
      bucket_regional_domain_name = s3_bucket.bucket_regional_domain_name
    }],
    ecr = [for ecr in aws_ecr_repository.ecr : {
      name           = ecr.name
      repository_url = ecr.repository_url
    }]
  }
}