
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
} 