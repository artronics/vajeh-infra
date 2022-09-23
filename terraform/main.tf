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
  environment = "prod"
  tier    = "infrastructure"
}

locals {
  root_domain = "artronics.me.uk"
}

provider "aws" {
  region = "eu-west-2"

  default_tags {
    tags = {
      project     = local.project
      environment = local.environment
      tier        = local.tier
    }
  }
}

provider "aws" {
  alias  = "acm_provider"
  region = "eu-west-2"
}
