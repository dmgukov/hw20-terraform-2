module "instance" {
  source = "./modules/instance"

  name           = "hw20-server"
  key_name       = var.key_name
  instance_count = local.instance_count

  create_ssm_role = "true"
}

locals {
  instance_count = 2
}

