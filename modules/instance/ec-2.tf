resource "aws_instance" "this" {

  count = var.instance_count

  ami = data.aws_ami.amazonlinux2.id

  user_data = file("${path.module}/user.sh")

  instance_type = var.type

  root_block_device {
    volume_size = var.disk_size
    volume_type = var.disk_type
  }

  key_name = var.key_name

  tags = {
    Name = var.instance_count == 1 ? var.name : "${var.name}-${count.index}"
  }

  vpc_security_group_ids = var.security_group_id != "" ? [var.security_group_id] : [aws_security_group.fallback[0].id]

  iam_instance_profile = var.create_ssm_role == "true" ? aws_iam_role.ssm_role[0].name : null

  lifecycle {
    ignore_changes = [ami]
  }
}
