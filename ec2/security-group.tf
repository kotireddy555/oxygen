resource "aws_security_group" "sg" {
  name_prefix = "${var.app_name}-${lower(var.environment)} ec2 security group"
  vpc_id = "${var.vpc_id}"

  lifecycle {
    create_before_destroy = true
  }
  tags = "${module.tags.hp-custom-tags}"
}

resource "aws_security_group_rule" "sg_ingress_443" {
  security_group_id = "${aws_security_group.sg.id}"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  type              = "ingress"
  count             = "${var.sg_ingress_443_enabled}"

  cidr_blocks = ["0.0.0.0/0"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "sg_ingress_80" {
  security_group_id = "${aws_security_group.sg.id}"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  type              = "ingress"
  count             = "${var.sg_ingress_80_enabled}"

  cidr_blocks = ["0.0.0.0/0"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "sg_ingress_custom" {
  security_group_id = "${aws_security_group.sg.id}"
  from_port         = "${var.custom_port}"
  to_port           = "${var.custom_port}"
  protocol          = "tcp"
  type              = "ingress"
  count             = "${var.sg_ingress_custom_rule_enabled}"

  cidr_blocks = ["0.0.0.0/0"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "sg_egress_all" {
  security_group_id = "${aws_security_group.sg.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  type              = "egress"
  count             = "${var.sg_egress_all_enabled}"

  cidr_blocks = [
    "0.0.0.0/0",
  ]

  lifecycle {
    create_before_destroy = true
  }
}