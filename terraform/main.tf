terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4"
    }
  }

  backend "s3" {
    key    = "state"
    region = "eu-west-2"
  }
}

locals {
  tier          = "infra"
  workspace     = "infra"
}

provider "aws" {
  region = "eu-west-2"

  default_tags {
    tags = {
      Workspace = local.workspace
      Project   = var.project
      Tier      = local.tier
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
      Workspace = local.workspace
      Project   = var.project
      Tier      = local.tier
    }
  }
}

provider "aws" {
  alias  = "ptl"
  region = "eu-west-2"

  default_tags {
    tags = {
      Workspace = local.workspace
      Project   = var.project
      Tier      = local.tier
    }
  }
}

provider "aws" {
  alias  = "acm_provider"
  region = "us-east-1"
  default_tags {
    tags = {
      Workspace = local.workspace
      Project   = var.project
      Tier      = local.tier
    }
  }
}
