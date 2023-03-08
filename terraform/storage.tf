locals {
  // TODO: variable this and pass it to platform subnet
  platform_subnet_az_1 = "eu-west-2a"
}

resource "aws_efs_file_system" "platform_storage" {
  creation_token         = "${local.prefix}-platform"
  availability_zone_name = local.platform_subnet_az_1
  tags = {
    Name = "${local.prefix} Platform"
  }
}

resource "aws_efs_access_point" "terraform_plugin_cache_efs_access_point" {
  file_system_id = aws_efs_file_system.platform_storage.id

  root_directory {
    path = "/terraform-plugin-cache"
    creation_info {
      owner_gid   = 0
      owner_uid   = 0
      permissions = "666"
    }
  }
  posix_user {
    uid            = 0
    gid            = 0
    secondary_gids = [1000]
  }

  tags = {
    Name = "terraform-plugin-cache"
  }
}

resource "aws_efs_mount_target" "terraform_plugin_cache_mount" {
  file_system_id  = aws_efs_file_system.platform_storage.id
  subnet_id       = module.network.platform_subnet_ids[0]
  security_groups = [module.network.vpc_default_security_group]
}
