terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4"
    }
  }

  backend "s3" {
    bucket = "terraform-vajeh-infra"
    key    = "dev"
    region = "eu-west-2"
  }
}

locals {
  root_project = "vajeh"
  project = "vajeh-infra"
  tier    = "infrastructure"
}

provider "aws" {
  region = "eu-west-2"

  default_tags {
    tags = {
      project     = local.project
      environment = var.environment
      tier        = local.tier
    }
  }
}

provider "aws" {
  alias  = "acm_provider"
  region = "eu-west-2"
}
