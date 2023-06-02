resource "aws_security_group" "fallback" {
  count = var.security_group_id == "" ? 1 : 0

  name        = "fallback-sg"
  description = "SG created as fallback"

  vpc_id = data.aws_vpc.default.id

  tags = {
    Name = "fallback-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  count = var.security_group_id == "" ? 1 : 0

  security_group_id = aws_security_group.fallback[0].id

  description = "Allow SSH from ALL IPs"
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22

  tags = {
    Name = "ssh-allow-all"
  }
}

resource "aws_vpc_security_group_egress_rule" "all" {
  count = var.security_group_id == "" ? 1 : 0

  security_group_id = aws_security_group.fallback[0].id

  description = "Allow egress for all"
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1

  tags = {
    Name = "egress-all"
  }
}