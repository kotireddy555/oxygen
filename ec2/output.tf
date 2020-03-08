output "instance_id" {
  value = "${aws_instance.ec2.id}"
}

output "private_ip" {
  value = "${aws_instance.ec2.private_ip}"
}

output "sg_id" {
  value = "${aws_security_group.sg.id}"
}