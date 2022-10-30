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
  alias = "main"
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
  region = "us-east-1"
  default_tags {
    tags = {
      project     = local.project
      environment = local.environment
      tier        = local.tier
    }
  }
}
