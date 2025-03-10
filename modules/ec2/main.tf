resource "aws_security_group" "public_sg" {
  name        = "allow_public_access"
  description = "Allow Traffic from Anywhere"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.public_instance_sg_ports
    content {
      from_port   = ingress.value["port"]
      to_port     = ingress.value["port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = var.public_sg
    "env"  = var.env
  }
}

resource "aws_security_group" "private_sg" {
  name        = "allow_from_public_instances"
  description = "Allow traffic from public instance sg only"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.private_instance_sg_ports
    content {
      from_port       = ingress.value["port"]
      to_port         = ingress.value["port"]
      protocol        = ingress.value["protocol"]
      security_groups = [aws_security_group.public_sg.id]
    }
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.public_sg.id]
  }

  tags = {
    "Name" = var.private_sg
    "env" = var.env
     
  }
}

resource "tls_private_key" "ssh" {
  count       = var.create_key_pair ? 1 : 0
  algorithm   = "RSA"
  rsa_bits    = 4096
}

resource "local_file" "private_key" {
  count           = var.create_key_pair ? 1 : 0
  content         = tls_private_key.ssh[0].private_key_pem
  filename        = var.private_key_location
  file_permission = "0400"
}

resource "aws_key_pair" "aws_ec2_access_key" {
  count      = var.create_key_pair ? 1 : 0
  key_name   = var.key_name
  public_key = tls_private_key.ssh[0].public_key_openssh
}

resource "aws_instance" "public_hosts" {
  for_each               = { for index, conf in var.public_instance_conf : index => conf }
  ami                    = each.value.ami
  instance_type          = each.value.instance_type
  subnet_id              = each.value.subnet_id
  key_name               = each.value.key_name
  vpc_security_group_ids = each.value.vpc_security_group_ids
  user_data              = lookup(each.value, "user_data", null)

  tags = merge(
    {
      "Name" = "${var.public_instance_name[each.key % length(var.public_instance_name)]}-${each.key}"
    }
  )
}

resource "aws_instance" "private_hosts" {
  for_each               = { for index, conf in var.private_instance_conf : index => conf }
  ami                    = each.value.ami
  instance_type          = each.value.instance_type
  subnet_id              = each.value.subnet_id
  key_name               = each.value.key_name
  vpc_security_group_ids = each.value.vpc_security_group_ids

  tags = merge(
    {
      "Name" = "${var.private_instance_name[each.key % length(var.private_instance_name)]}-${each.key}"
    }
  )
}

