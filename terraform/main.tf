terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4"
    }
  }

  backend "s3" {
    bucket = "vajeh-infra-ptl-terraform-state"
    key    = "state"
    region = "eu-west-2"
  }
}

data "aws_caller_identity" "current" {}
locals {
  account_id = data.aws_caller_identity.current.account_id
}

locals {
  root_project = "vajeh"
  project      = "infra"
  environment  = terraform.workspace
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
  access_key = var.root_aws_access_key_id
  secret_key = var.root_aws_secret_access_key

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
