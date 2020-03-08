module "tags" {
  source = "../hp-it-infra-enabled-tags"

  environment = "${var.environment}"
  tag_contact_email = "${var.tag_contact_email}"
  tag_cost_center = "${var.tag_cost_center}"
  tag_name = "${var.app_name}"
  tag_criticality = "${var.tag_criticality}"
  tag_app_name = "${var.tag_app_name}"
  tag_eprid = "${var.tag_eprid}"
  tag_location_code = "${var.tag_location_code}"
  tag_mru = "${var.tag_mru}"
}

resource "aws_instance" "ec2" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"

  vpc_security_group_ids = ["${concat(var.default_sgs, split(",", aws_security_group.sg.id))}"]
  subnet_id = "${var.subnet_id}"

  # The name of our SSH keypair we created above.
  key_name = "${var.key_name}"

  user_data = "${var.user_data}"
  iam_instance_profile = "${var.iam_instance_profile}"

  private_ip = "${var.private_ip}"

  tags {
    Name = "${var.app_name}-${lower(var.environment)}",
    Category = "Environment:${var.environment}+Criticality:${var.tag_criticality}+Role:Application",
    Owner = "EPRID:${var.tag_eprid}+Name:${var.app_name}+Contact:${var.tag_contact_email}",
    CostManagement = "CostCenter:${var.tag_cost_center}+MRU:${var.tag_mru}+LocationCode:${var.tag_location_code}"
  }
}