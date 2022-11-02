terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4"
    }
  }

  backend "s3" {
    #    TODO: remove backup
    bucket = "vajeh-infra-ptl-terraform-state-backup"
    key    = "state"
    region = "eu-west-2"
  }
}

locals {
  root_project = "vajeh"
  project      = "infra"
  environment  = "ptl"
  tier         = "infrastructure"
}

provider "aws" {
  region = "eu-west-2"

  default_tags {
    tags = {
      Project     = local.project
      Environment = local.environment
      Tier        = local.tier
    }
  }
}

provider "aws" {
  alias      = "root"
  region     = "eu-west-2"
  access_key = var.aws_root_access_key
  secret_key = var.aws_root_secret_key

  default_tags {
    tags = {
      Project     = local.project
      Environment = local.environment
      Tier        = local.tier
    }
  }
}

provider "aws" {
  alias  = "acm_provider"
  region = "us-east-1"
  default_tags {
    tags = {
      Project     = local.project
      Environment = local.environment
      Tier        = local.tier
    }
  }
}
