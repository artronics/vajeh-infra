terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4"
    }
  }

  backend "s3" {
    bucket = "terraform-vajeh-infra"
    key    = "state"
    region = "eu-west-2"
  }
}

locals {
  root_project = "vajeh"
  project = "infra"
  environment = "ptl"
  tier    = "infrastructure"
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
  alias = "main"
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
